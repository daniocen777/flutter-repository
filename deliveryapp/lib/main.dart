import 'package:flutter/material.dart';

import 'src/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: 'welcome',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Color.fromRGBO(10, 31, 68, 1.0),
        disabledColor: Color.fromRGBO(142, 142, 147, 1.2),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
      ),
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
