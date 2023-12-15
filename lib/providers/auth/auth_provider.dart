import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:prayer/constants/mixpanel.dart';
import 'package:prayer/constants/talker.dart';
import 'package:prayer/errors.dart';
import 'package:prayer/model/user/user_model.dart';
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
      talker.debug("Sign In Initiated");
      mixpanel.timeEvent("Sign In");
      state = AsyncValue.loading();
      final authRepo = GetIt.I<AuthenticationRepository>();
      final UserCredential credential = await switch (provider) {
        AuthProvider.google => authRepo.signInWithGoogle(),
        AuthProvider.apple => authRepo.signInWithApple(),
        _ => authRepo.signInWithTwitter(),
      };
      if (credential.user == null) {
        throw MissingUidError();
      }
      final data =
          await GetIt.I<UserRepository>().fetchUser(uid: credential.user!.uid);
      mixpanel.track("Sign In", properties: {'provider': provider.name});
      state = AsyncValue.data(
          data == null ? AuthStateSignedIn() : AuthStateSignedUp(data));
      talker.good('Sign In Success: ${data?.toJson()}');
    } catch (error, stackTrace) {
      if ((error is FirebaseAuthException &&
              (error.code == 'unknown' || error.code == 'canceled')) ||
          error is SignInCancelled) {
        talker.debug("Sign In Cancelled");
        state = AsyncValue.data(AuthStateSignedOut());
        return;
      }
      talker.handle(
          error,
          stackTrace,
          generateLogMessage("Sign In Error", data: {
            'provider': provider.name,
          }));
      mixpanel.track("Sign In", properties: {'status': false});
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createUser({
    required String username,
    required String name,
    String? bio,
  }) async {
    try {
      final user = await GetIt.I<UserRepository>().createUser(
        username: username,
        name: name,
        bio: bio,
      );
      if (user == null) {
        throw MissingUidError();
      }
      state = AsyncValue.data(AuthStateSignedUp(user));
    } catch (error, stackTrace) {
      if (!(error is DuplicatedUsernameException)) {
        talker.handle(
            error,
            stackTrace,
            generateLogMessage("Sign Up Failed", data: {
              'username': username,
              'name': name,
              'bio': bio,
            }));
      }
      rethrow;
    }
  }

  void setUser(PUser? user) {
    if (user == null) {
      state = AsyncValue.data(AuthStateSignedOut());
    } else {
      state = AsyncValue.data(AuthStateSignedUp(user));
    }
  }

  Function() _subscribe() {
    final authSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        talker.debug("[FirebaseAuth] User Signed Out");
        state = AsyncValue.data(AuthStateSignedOut());
      } else {
        talker.debug("[FirebaseAuth] User Signed In");
        mixpanel.identify(user.uid);
      }
    });
    return () {
      authSubscription.cancel();
    };
  }
}
