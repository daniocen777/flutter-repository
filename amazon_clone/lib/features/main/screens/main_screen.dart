import 'package:flutter/material.dart';

import 'package:amazon_clone/features/auth/screens/auth_screen.dart';

class MainScreen extends StatelessWidget {
  static const String route = 'main';
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Holas')),
      body: Column(
        children: [
          const Center(
            child: Text('Hello World'),
          ),
          Builder(builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AuthScreen.route);
                },
                child: const Text('click'));
          })
        ],
      ),
    );
  }
}
