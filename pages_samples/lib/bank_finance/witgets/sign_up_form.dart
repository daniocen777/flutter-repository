import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../witgets/custom_button.dart';
import '../witgets/text_input.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _checked = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400.0),
                  child: Form(
                      child: Column(children: [
                    TextInput(
                        labelText: 'Full Name',
                        filled: true,
                        onFieldSubmitted: (String text) {
                          print('Full Name');
                        }),
                    SizedBox(height: 8.0),
                    TextInput(
                        labelText: 'Email Address',
                        onFieldSubmitted: (String text) {
                          print('Email');
                        }),
                    SizedBox(height: 8.0),
                    TextInput(
                        labelText: 'Password',
                        obscureText: true,
                        suffix: IconButton(
                            onPressed: () => print('Ver'),
                            icon:
                                Icon(Icons.remove_red_eye, color: Colors.grey)),
                        onFieldSubmitted: (String text) {
                          print('Password');
                        }),
                    SizedBox(height: 20.0),
                    Container(
                      height: 50.0,
                      child: CheckboxListTile(
                          title: Text(
                            'By creating your account yo have to agree with our Tearns and Conditions',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _checked,
                          onChanged: (bool? value) {
                            print('VALOR => $value');
                            setState(() {
                              _checked = value!;
                            });
                          },
                          activeColor: primaryColor.withOpacity(0.2),
                          checkColor: Colors.grey),
                    ),
                    /* Checkbox(
                        value: _checked,
                        onChanged: (bool? value) {
                          print('VALOR => $value');
                          setState(() {
                            _checked = value!;
                          });
                        }), */
                    SizedBox(height: 40.0),
                    CustomButton(
                        label: 'Sign up my account',
                        fullWidth: true,
                        onPressed: () => print('crear cuenta')),
                    SizedBox(height: 10.0),
                    CustomButton(
                        label: 'Sign up with phone number',
                        backgroundColor: accentColor,
                        fullWidth: true,
                        onPressed: () => print('crear cuenta'))
                  ])))
            ]));
  }
}
