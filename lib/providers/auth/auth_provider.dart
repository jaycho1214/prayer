import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/model/user_model.dart';
import 'package:prayer/providers/auth/auth_state.dart';
import 'package:prayer/repo/authentication_repository.dart';
import 'package:prayer/repo/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.g.dart';

enum AuthProvider { google, apple, x }

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<AuthState> build() async {
    final unsubscribe = _subscribe();
    ref.onDispose(unsubscribe);
    ref.listenSelf((_, next) {
      Sentry.configureScope((scope) {
        if (next.value == null) {
          scope.setUser(null);
        } else if (next.value is AuthStateSignedUp) {
          final u = next.value as AuthStateSignedUp;
          scope.setUser(SentryUser(
            id: u.user.uid,
            username: u.user.username,
            email: u.user.email,
            name: u.user.name,
          ));
        }
      });
      if (next.value != null) {
        GetIt.I<SharedPreferences>().setInt(
            'auth.signInStatus',
            switch (next.value!) {
              AuthStateSignedOut() => 0,
              AuthStateSignedIn() => 1,
              AuthStateSignedUp() => 2,
            });
      }
    });
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return AuthStateSignedOut();
    }
    final data = await GetIt.I<UserRepository>().fetchUser(uid: uid);
    if (data == null) {
      return AuthStateSignedIn();
    } else {
      return AuthStateSignedUp(data);
    }
  }

  Future<void> signIn(AuthProvider provider) async {
    try {
      state = AsyncValue.loading();
      final authRepo = GetIt.I<AuthenticationRepository>();
      final UserCredential credential = await switch (provider) {
        AuthProvider.google => authRepo.signInWithGoogle(),
        AuthProvider.apple => authRepo.signInWithApple(),
        _ => authRepo.signInWithTwitter(),
      };
      if (credential.user == null) {
        state = AsyncValue.error(MissingUidError(), StackTrace.current);
        return;
      }
      final data =
          await GetIt.I<UserRepository>().fetchUser(uid: credential.user!.uid);
      talker.info(
          'User (${credential.user!.uid}) data fetched: ${data?.toJson()}');
      state = AsyncValue.data(
          data == null ? AuthStateSignedIn() : AuthStateSignedUp(data));
    } catch (error, stackTrace) {
      talker.error("Error while logging in", error, stackTrace);
      if (error is FirebaseAuthException) {
        if (error.code == 'canceled') {
          state = AsyncValue.data(AuthStateSignedOut());
          return;
        }
      }
      Sentry.captureException(error, stackTrace: stackTrace);
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void updateUser(PUser? user) {
    assert(user == null || user.uid == FirebaseAuth.instance.currentUser?.uid);
    state = AsyncValue.data(
        user == null ? AuthStateSignedOut() : AuthStateSignedUp(user));
  }

  Function() _subscribe() {
    final authSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      talker.debug("Auth states changed");
      if (user == null) {
        state = AsyncValue.data(AuthStateSignedOut());
      } else {
        mixpanel.identify(user.uid);
      }
    });
    return () {
      authSubscription.cancel();
    };
  }
}
