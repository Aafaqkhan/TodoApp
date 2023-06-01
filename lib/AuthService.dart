import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_todo/homeScreen.dart';
import 'package:new_todo/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  Future<void> handleGoogleSignIn(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await saveUserId(user.uid);
        // Navigate to the desired screen after successful sign-in

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userId: user.uid,
            ),
          ),
        );
      }
    } catch (error) {
      print('Sign in with Google failed: $error');
    }
  }

  Future<void> handleEmailSignIn(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        await saveUserId(user.uid);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userId: user.uid,
            ),
          ),
        );
      }
    } catch (error) {
      print('Sign in with email and password failed: $error');
    }
  }

  Future<void> handleEmailSignUp(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        await saveUserId(user.uid);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userId: user.uid,
            ),
          ),
        );
      }
    } catch (error) {
      print('Sign up with email and password failed: $error');
    }
  }

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<void> handleSignOut(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp(),
        ),
      );
    } catch (error) {
      print('Sign out failed: $error');
    }
  }
}
