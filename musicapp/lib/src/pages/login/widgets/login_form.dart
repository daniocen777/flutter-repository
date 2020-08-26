import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/src/libs/auth.dart';
import 'package:musicapp/src/pages/login/forgot-password_page.dart';

import 'package:musicapp/src/pages/login/widgets/input_text.dart';
import 'package:musicapp/src/utils/extras.dart';
import 'package:musicapp/src/widgets/circle_button.dart';
import 'package:musicapp/src/widgets/rounded_button.dart';

import 'package:musicapp/src/pages/home/home_page.dart';
import 'package:musicapp/src/pages/login/register_page.dart';
import 'package:musicapp/src/utils/responsive.dart';

class LoginForm extends StatefulWidget {
  final Alignment alignment;

  const LoginForm({Key key, this.alignment = Alignment.bottomCenter})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<InputTextState> _emailKey = GlobalKey<InputTextState>();
  final GlobalKey<InputTextState> _passwordKey = GlobalKey<InputTextState>();

  void _gotTo(FirebaseUser user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print('Login Failed');
    }
  }

  Future<void> _submit() async {
    final String email = _emailKey.currentState.value;
    final String password = _passwordKey.currentState.value;
    final bool emailOk = _emailKey.currentState.isOk;
    final bool passwordOk = _passwordKey.currentState.isOk;
    if (emailOk && passwordOk) {
      final FirebaseUser user = await Auth.instance
          .loginByPassword(context, email: email, password: password);
      _gotTo(user);
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
          width: 330,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            /* mainAxisSize: MainAxisSize.min, */
            children: <Widget>[
              InputText(
                key: _emailKey,
                keyboardType: TextInputType.emailAddress,
                iconPath: 'assets/pages/login/icons/mail.svg',
                placeholder: 'Email Address',
                validator: (text) => Extras.isValidEmail(text),
              ),
              SizedBox(height: responsive.ip(2.0)),
              InputText(
                  key: _passwordKey,
                  obscureText: true,
                  iconPath: 'assets/pages/login/icons/key.svg',
                  placeholder: 'Password',
                  validator: (text) {
                    return text.trim().length >= 6;
                  }),
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Forgot password',
                      style: TextStyle(fontFamily: 'sans')),
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordPage.routeName);
                  },
                ),
              ),
              SizedBox(height: responsive.ip(2.0)),
              RoundedButton(
                label: 'Sign In',
                onPressed: this._submit,
              ),
              SizedBox(height: responsive.ip(3.3)),
              Text('Or continue with:'),
              SizedBox(height: responsive.ip(1.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /* Auth facebook */
                  CircleButton(
                    backgroundColor: Color(0xff448AFF),
                    size: 55.0,
                    iconPath: 'assets/pages/login/icons/facebook.svg',
                    onPressed: () {},
                  ),
                  SizedBox(width: 20.0),
                  /* Auth Google */
                  CircleButton(
                    size: 55.0,
                    backgroundColor: Color(0xffFF1744),
                    iconPath: 'assets/pages/login/icons/ui.svg',
                    onPressed: () async {
                      final FirebaseUser user =
                          await Auth.instance.google(context);
                      _gotTo(user);
                    },
                  )
                ],
              ),
              SizedBox(height: responsive.ip(2.7)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account?"),
                  SizedBox(width: 10.0),
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text('Sign Up',
                        style: TextStyle(
                            fontFamily: 'sans', fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
