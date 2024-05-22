import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/home_page.dart';

class AuthenticationService{
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        log("User signed in: ${user.email}");
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      }

      return user;
    } catch (e) {
      log("Error signing in with Google: $e");
      return null;
    }
  }

  static Future<User?> registerUser({required String name, required String email, required String password})async{
    UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await user.user?.updateDisplayName(name);
    if(user.user != null){
      return user.user;
    }else{
      return null;
    }
  }

  static Future<User?> loginUser({required String email, required String password})async{
    UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
    if(user.user != null){
      return user.user;
    }else{
      return null;
    }
  }

  static Future<void> editPassword(String password)async{
    User? user = auth.currentUser;

    if(user!=null){
      user.updatePassword(password);
    }
  }

  static Future<void> logout()async{
    await auth.signOut();
    await googleSignIn.signOut();
  }

  static Future<void> delete()async{
    User? user = auth.currentUser;

    if(user!=null){
      log("delete");
      await user.delete();
      await googleSignIn.disconnect();
    }
  }
}