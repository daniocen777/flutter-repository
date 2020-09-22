import 'package:chatapp/pages/chat_page.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: ChatPage.route,
        routes: appRoutes);
  }
}
