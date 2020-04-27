import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_avanzado/src/auth/auth.dart';
import 'package:login_avanzado/src/pages/login/widgets/input_text.dart';
import 'package:login_avanzado/src/utils/responsive.dart';
import 'package:login_avanzado/src/widgets/circle_button.dart';
import 'package:login_avanzado/src/widgets/rounded_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return SafeArea(
      top: false,
      child: Container(
        width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InputTextLogin(
              iconPath: 'assets/images/login/icons/email.svg',
              placeholder: 'Email address',
            ),
            SizedBox(height: responsive.ip(2.0)),
            InputTextLogin(
              iconPath: 'assets/images/login/icons/key.svg',
              placeholder: 'Password',
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Forgot password?',
                      style: TextStyle(fontFamily: 'sans')),
                  onPressed: () {
                    print('Forgot password');
                  }),
            ),
            SizedBox(height: responsive.ip(2.0)),
            RoundedButton(
              label: 'Sign In',
              onPressed: () {
                print('Sign In');
              },
            ),
            SizedBox(height: responsive.ip(3.0)),
            Text('Or continue with'),
            SizedBox(height: responsive.ip(1.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleButton(
                  size: 55.0,
                  backgroundColor: Color(0xff448AFF),
                  iconPath: 'assets/images/login/icons/facebook.svg',
                  onPressed: () {
                    print('Facebook sign in');
                  },
                ),
                SizedBox(width: 20.0),
                CircleButton(
                  size: 55.0,
                  backgroundColor: Color(0xffFF1744),
                  iconPath: 'assets/images/login/icons/google.svg',
                  onPressed: () async {
                    await Auth.intance.google();
                    print('Listo - google');
                  },
                ),
              ],
            ),
            SizedBox(height: responsive.ip(2.7)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?"),
                CupertinoButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'sans', fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      print('Sign UP');
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
