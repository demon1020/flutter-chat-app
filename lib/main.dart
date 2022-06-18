import 'package:chat_app/feature/chat/provider/chat_provider.dart';
import 'package:chat_app/feature/login/models/users.dart';
import 'package:chat_app/feature/login/provider/login_provider.dart';
import 'package:chat_app/feature/login/components/wrapper.dart';
import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Users?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'Chat App',
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
