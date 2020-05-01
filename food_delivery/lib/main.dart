import 'package:flutter/material.dart';
import 'package:food_delivery/src/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Food Delivery UI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[50],
            primaryColor: Colors.deepOrangeAccent),
        home: HomeScreen());
  }
}
