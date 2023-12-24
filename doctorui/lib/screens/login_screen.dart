import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var passTogle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('/assets/images/doctors.png'),
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Enter Username'),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text('Enter Username'),
                      prefixIcon: const Icon(Icons.lock),
                      suffix: InkWell(
                        onTap: () {},
                        child: passTogle
                            ? const Icon(Icons.remove_red_eye_sharp)
                            : const Icon(Icons.visibility_off_sharp),
                      )),
                ),
              ),
            ],
          )),
        ));
  }
}
