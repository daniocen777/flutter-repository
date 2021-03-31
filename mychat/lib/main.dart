import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './utils/colors.dart';
import './screens/auth_screen.dart';
import './screens/register_screen.dart';
import './screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondColor,
          brightness: Brightness.light),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        },
      ),
      routes: {
        AuthScreen.route: (BuildContext context) => AuthScreen(),
        RegisterScreen.route: (BuildContext context) => RegisterScreen(),
        ChatScreen.route: (BuildContext context) => ChatScreen(),
      },
    );
  }
}
