import 'package:chat_app/feature/login/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // create user obj based on firebase user
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream to custom user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // // auth change user stream to custom user stream
  // Stream<Users?> get user {
  //   return _auth.authStateChanges().map(_userFromFirebaseUser);
  // }

  getCurrentUser(){
    return _auth.currentUser!.displayName;
  }

  // sign in with email and password
    Future<User?> signIn(String email, String password) async {

    try {
      User? user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password))
          .user;

      if (user != null) {
        print("Login Successful");
        _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .get()
            .then((value) => user.updateDisplayName(value['name']));

        return user;
      } else {
        print("Login Failed");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // signUp with email and password
  Future<User?> signUp(String name, String email,String phone, String password) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user;

      if (user != null) {
        print("Account created Successfully");

        user.updateDisplayName(name);

        await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
          "name": name,
          "email": email,
          "phone": phone,
          "status": "Unavailable",
          "uid": _auth.currentUser!.uid,
        });
        return user;
      } else {
        print("Account creation failed");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign out
    Future signOut(BuildContext context) async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

