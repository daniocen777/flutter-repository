import 'package:flutter/material.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/ui/routes/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => router.pushNamed(Routes.register),
                  child: const Text('Sign Up'))
            ],
          ),
        ),
      ),
    );
  }
}
