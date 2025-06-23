import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //sign user in
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      //diagnose errors
      print('FirebaseAuthException code: ${e.code}');
      print('FirebaseAuthException message: ${e.message}');
      print('FirebaseAuthException details: ${e.toString()}');

      switch (e.code) {
        case 'invalid-email':
          print('Invalid email format');
          break;
        case 'user-disabled':
          print('User account disabled');
          break;
        case 'user-not-found':
          print('No user found');
          break;
        case 'wrong-password':
          print('Wrong password');
          break;
        default:
          print('Unknown error: ${e.code}');
      }
      //catch errors
      throw Exception(e.code);
    }
  }

  //sign user out
}
