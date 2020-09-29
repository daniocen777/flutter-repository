import 'package:chatapp/pages/loading_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chatapp/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => AuthService(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat App',
          initialRoute: LoadingPage.route,
          routes: appRoutes),
    );
  }
}
