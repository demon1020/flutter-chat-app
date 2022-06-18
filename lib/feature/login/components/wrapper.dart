import 'package:chat_app/feature/login/screen/sign_in.dart';
import 'package:chat_app/feature/login/models/users.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/feature/home/screen/main_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if (user != null) {
      return MainPage();
    } else {
      return SignIn();
    }
  }
}
