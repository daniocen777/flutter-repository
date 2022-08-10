import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth {
  sigin, signup
}

class RegisterScreen extends StatelessWidget {
  static const String route = 'register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  // const Auth auth = Auth.signup;
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Welcome',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
             /*  ListTile(
                title: Text('Create new account',
                    style: TextStyle(fontWeight: FontWeight.w200)),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signup,
                      groupValue: auth,
                    )
              ) */
            ],
          ),
        )));
  }
}
