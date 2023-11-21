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

part 'auth_provider.g.dart';

enum AuthProvider { google, apple, x }

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<AuthState> build() async {
    final unsubscribe = _subscribe();
    ref.onDispose(unsubscribe);

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
        mixpanel.registerSuperProperties({'\$email': user.email});
      }
    });
    return () {
      authSubscription.cancel();
    };
  }
}
