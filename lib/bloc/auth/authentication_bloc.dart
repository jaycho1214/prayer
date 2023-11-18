import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:prayer/bloc/auth/authentication_event.dart';
import 'package:prayer/bloc/auth/authentication_state.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/model/user_model.dart';
import 'package:prayer/repo/authentication_repository.dart';
import 'package:prayer/repo/user_repository.dart';

enum AuthenticationProvider { google, apple, x }

// This flag needs to guarantee that it signs out after the data of user is null after user has signed up.
bool flag = false;

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  late final StreamSubscription _authSubscription;
  late final StreamSubscription _hiveSubscription;
  final AuthenticationRepository authRepository;
  final UserRepository userRepository;

  AuthenticationBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(FirebaseAuth.instance.currentUser == null
            ? const AuthenticationState.idle()
            : const AuthenticationState.signedIn()) {
    on<AuthenticationEventSignIn>(signIn);
    on<AuthenticationEventSignUp>(signUp);
    on<AuthenticationEventSignOut>(signOut);
    on<AuthenticationEventRefresh>(refresh);

    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      talker.debug("Auth states changed");
      if (user == null) {
        add(const AuthenticationEvent.signOut());
      } else {
        mixpanel.identify(user.uid);
        mixpanel.registerSuperProperties({'\$email': user.email});
      }
    });
    _hiveSubscription =
        Hive.box<dynamic>('cache_bloc').watch(key: 'myProfile').listen((event) {
      if (event.value != null) {
        flag = true;
      }
      if (flag &&
          event.value == null &&
          FirebaseAuth.instance.currentUser != null) {
        if (!kDebugMode) {
          FirebaseAuth.instance.signOut();
        }
      }
    });
  }

  Future<void> signIn(
    AuthenticationEventSignIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    talker.info('Started logging in with ${event.provider}...');
    emit(AuthenticationState.signInLoading(event.provider));

    try {
      UserCredential? credential;
      if (event.provider == AuthenticationProvider.google) {
        credential = await authRepository.signInWithGoogle();
      } else if (event.provider == AuthenticationProvider.apple) {
        credential = await authRepository.signInWithApple();
      } else {
        credential = await authRepository.signInWithTwitter();
      }
      if (credential.user == null) {
        throw 'user not found';
      }
      final data = await userRepository.fetchUser(uid: credential.user!.uid);
      talker.info(
          'User (${credential.user!.uid}) data fetched: ${data?.toJson()}');
      emit(data != null
          ? AuthenticationState.signedUp(data)
          : const AuthenticationState.signedIn());
    } catch (error, stackTrace) {
      talker.error("Error found while logging in", error, stackTrace);
      if (error is FirebaseAuthException) {
        if (error.code == 'canceled') {
          return emit(const AuthenticationState.idle());
        }
      }
      emit(const AuthenticationState.signInError());
    }
  }

  Future<void> signUp(
    AuthenticationEventSignUp event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      talker.error("User try to sign up without uid");
      return emit(const AuthenticationState.idle());
    }
    emit(AuthenticationState.signUpLoading());
    try {
      talker.debug('Signing up with: ${event.username}');
      final data = await userRepository.createUser(
        username: event.username,
        name: event.name,
        bio: event.bio,
      );
      if (data == null) {
        talker.error("Unable to sign up successfully");
        throw "Unable to sign up successfully";
      }
      talker.good("User signed up successfully");
      emit(AuthenticationState.signedUp(data));
    } catch (e) {
      talker.error("Failed to sign up: $e");
      if (e is String) {
        return emit(AuthenticationState.signUpError(e));
      }
      return emit(
          const AuthenticationState.signUpError("Unknown error occured"));
    }
  }

  Future<void> refresh(
    AuthenticationEventRefresh event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (FirebaseAuth.instance.currentUser == null) {
      talker.error("User try to sign up without uid");
      return emit(const AuthenticationState.idle());
    }
    try {
      final data = await userRepository.fetchUser(
          uid: FirebaseAuth.instance.currentUser!.uid);
      if (data == null) {
        return emit(const AuthenticationState.idle());
      }
      talker.good("User data refreshed: ${data.toJson()}");
      return emit(AuthenticationState.signedUp(data));
    } catch (e) {
      talker.error("Unable to refresh the loggined user");
    }
  }

  Future<void> signOut(
    AuthenticationEventSignOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.idle());
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      return const AuthenticationState.idle();
    }
    if (json['state'] == 3) {
      return AuthenticationState.signedUp(PUser.fromJson(json['user']));
    }
    return const AuthenticationState.idle();
  }

  @override
  Map<String, dynamic> toJson(AuthenticationState state) => {
        'state': state.map<int>(
          idle: (_) => 0,
          signInLoading: (_) => 0,
          signUpLoading: (_) => 0,
          signedIn: (_) => 2,
          signedUp: (_) => 3,
          signInError: (_) => -1,
          signUpError: (_) => -1,
        ),
        'user':
            state is AuthenticationStateSignedUp ? state.user.toJson() : null,
      };

  @override
  Future<void> close() async {
    await Future.wait([
      _authSubscription.cancel(),
      _hiveSubscription.cancel(),
    ]);
    return super.close();
  }
}
