// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthService {
  //Create user object based on Firebase user
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid, emailId: user.email!) : null;
  }

  // Auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign Up  with email & password
  Future emailSignUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (ex) {
      switch (ex) {
        case 'email-already-in-use':
          print(ex.toString());
          return null;
        case 'invalid-email':
          print(ex.toString());
          return null;
        case 'weak-password':
          print(ex.toString());
          return null;
        case 'operation-not-allowed':
          print(ex.toString());
          return null;
        default:
          print(ex.toString());
          return null;
      }
    }
  }

  // login with email & password
  Future emailLogin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (ex) {
      switch (ex) {
        case 'user-disabled':
          print(ex.toString());
          return null;
        case 'invalid-email':
          print(ex.toString());
          return null;
        case 'user-not-found':
          print(ex.toString());
          return null;
        case 'wrong-password':
          print(ex.toString());
          return null;
        default:
          print(ex.toString());
          return null;
      }
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }
}
