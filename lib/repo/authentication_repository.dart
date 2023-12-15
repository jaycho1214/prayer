import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prayer/errors.dart';

class AuthenticationRepository {
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw new SignInCancelled();
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    appleProvider.addScope('email');
    appleProvider.addScope('name');
    return FirebaseAuth.instance.signInWithProvider(appleProvider);
  }

  Future<UserCredential> signInWithTwitter() async {
    TwitterAuthProvider twitterProvider = TwitterAuthProvider();
    return FirebaseAuth.instance.signInWithProvider(twitterProvider);
  }
}
