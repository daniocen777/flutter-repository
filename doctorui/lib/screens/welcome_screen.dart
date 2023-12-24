import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/login_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push('/login') ,
                  child: const Text(
                    'SKIP',
                    style: TextStyle(color: Color(0xff7165d6), fontSize: 20.0),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/doctors.png'),
              ),
              const SizedBox(height: 50.0),
              const Text(
                'DOCTORS APPOINTMENT',
                style: TextStyle(
                    color: Color(0xff7165d6),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    wordSpacing: 2.0),
              ),
              const SizedBox(height: 50.0),
              const Text(
                'Appoint your doctor',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LoginButton(text: 'Log In'),
                  LoginButton(text: 'Sign Up')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
