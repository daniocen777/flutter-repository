import 'package:flutter/material.dart';

import 'package:Whatsappclone/routes/routes.dart';

import 'package:Whatsappclone/utils/colors.dart';

import 'package:Whatsappclone/pages/chat_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PRIMARY_COLOR,
        accentColor: SECOND_COLOR,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: ChatPage.route,
      routes: routes,
    );
  }
}
