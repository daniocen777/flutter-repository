import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        TextField(
            decoration: InputDecoration(
          filled: true,
          hintText: 'Enter your email',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
        ))
      ]),
    ));
  }
}
