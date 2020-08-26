import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/src/libs/auth.dart';

import 'package:musicapp/src/utils/app_colors.dart';
import 'package:musicapp/src/utils/dialogs.dart';
import 'package:musicapp/src/utils/extras.dart';
import 'package:musicapp/src/utils/responsive.dart';
import 'package:musicapp/src/widgets/rounded_button.dart';

import 'package:musicapp/src/pages/login/widgets/input_text.dart';
import 'package:musicapp/src/pages/home/home_page.dart';

class RegisterForm extends StatefulWidget {
  final Alignment alignment;

  const RegisterForm({Key key, this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool _agree = false;
  final GlobalKey<InputTextState> _usernameKey = GlobalKey<InputTextState>();
  final GlobalKey<InputTextState> _emailKey = GlobalKey<InputTextState>();
  final GlobalKey<InputTextState> _passwordKey = GlobalKey<InputTextState>();
  final GlobalKey<InputTextState> _validatePasswordKey =
      GlobalKey<InputTextState>();

  void _gotTo(FirebaseUser user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print('Register Failed');
    }
  }

  _submit() async {
    final String username = _usernameKey.currentState.value;
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;
    /* final String validatePassword = _validatePasswordKey.currentState.value; */
    final bool usernameOk = _usernameKey.currentState.isOk;
    final bool emailOk = _emailKey.currentState.isOk;
    final bool passwordOk = _passwordKey.currentState.isOk;
    final bool validatePasswordOk = _validatePasswordKey.currentState.isOk;

    if (usernameOk && emailOk && passwordOk && validatePasswordOk) {
      if (_agree) {
        final FirebaseUser user = await Auth.instance.signUp(context,
            username: username, email: email, password: password);
        _gotTo(user);
      } else {
        Dialogs.alert(context,
            description: 'You have to accept the terms and conditions');
      }
    } else {
      Dialogs.alert(context, description: 'Some fields are invalids');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Align(
      alignment: widget.alignment,
      child: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          constraints: BoxConstraints(maxWidth: 400.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('New Account',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: AppColors.primary,
                      fontFamily: 'raleway',
                      fontWeight: FontWeight.bold)),
              Text(
                  'Aquí podrá crear una nueva cuenta. Por favor, llene los siguientes datos, todos son obligatorios',
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w300)),
              SizedBox(height: responsive.ip(2.0)),
              InputText(
                key: _usernameKey,
                iconPath: 'assets/pages/login/icons/user.svg',
                placeholder: 'Username',
                validator: (text) {
                  return text.trim().length > 0;
                },
              ),
              SizedBox(height: responsive.ip(2.0)),
              InputText(
                key: _emailKey,
                keyboardType: TextInputType.emailAddress,
                iconPath: 'assets/pages/login/icons/mail.svg',
                placeholder: 'Email Address',
                validator: (text) => Extras.isValidEmail(text),
              ),
              SizedBox(height: responsive.ip(2.0)),
              InputText(
                obscureText: true,
                key: _passwordKey,
                iconPath: 'assets/pages/login/icons/key.svg',
                placeholder: 'Password',
                validator: (text) {
                  _validatePasswordKey.currentState?.checkValidation();
                  return text.trim().length >= 6;
                },
              ),
              SizedBox(height: responsive.ip(2.0)),
              InputText(
                obscureText: true,
                key: _validatePasswordKey,
                iconPath: 'assets/pages/login/icons/key.svg',
                placeholder: 'Confirm Password',
                validator: (text) {
                  return text.trim().length >= 6 &&
                      _validatePasswordKey.currentState.value ==
                          _passwordKey.currentState.value;
                },
              ),
              SizedBox(height: responsive.ip(2.0)),
              /* Wrap => Si no hay espacio, pasa a la siguiente línea */
              DefaultTextStyle(
                  style: TextStyle(
                      fontSize: responsive.ip(1.3),
                      color: Theme.of(context).textTheme.subtitle1.color),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Checkbox(
                          value: _agree,
                          onChanged: (value) {
                            setState(() {
                              _agree = value;
                            });
                          }),
                      Text('I agree to the '),
                      InkWell(
                        onTap: () {},
                        child: Text('terms of services',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text('& '),
                      InkWell(
                        onTap: () {},
                        child: Text('private plicy',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )),
              SizedBox(height: responsive.ip(2.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('← Back to Login')),
                  SizedBox(width: 10.0),
                  RoundedButton(label: 'Register', onPressed: _submit),
                ],
              ),
              SizedBox(height: responsive.ip(3.0)),
            ],
          ),
        ),
      ),
    );
  }
}
