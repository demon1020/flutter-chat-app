import 'package:chat_app/feature/login/models/user_info.dart';
import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  // // create user obj based on firebase user
  // UsersInfo? _userFromFirebaseUser(User? user) {
  //   return user != null ? UsersInfo(uid: user.uid) : null;
  // }

  getUserState() {
    AuthService().user;
  }

  Future<UsersInfo?> login(String email, String password) async {
    User? user = await AuthService().signIn(email, password);
    notifyListeners();
    return user != null ? UsersInfo(uid: user.uid) : null;
  }
}
