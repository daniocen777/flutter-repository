import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicapp/src/auths/auth.dart';
import 'package:musicapp/src/pages/home/home_page.dart';

import 'package:musicapp/src/pages/login/widgets/input_text.dart';
import 'package:musicapp/src/utils/responsive.dart';
import 'package:musicapp/src/widgets/circle_button.dart';
import 'package:musicapp/src/widgets/rounded_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  void _gotTo(BuildContext context, FirebaseUser user) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      print('Login Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      top: false,
      child: Container(
        width: 330,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputText(
                iconPath: 'assets/pages/login/icons/mail.svg',
                placeholder: 'Email Address'),
            SizedBox(height: responsive.ip(2.0)),
            InputText(
                iconPath: 'assets/pages/login/icons/key.svg',
                placeholder: 'Password'),
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text('Forgot password',
                    style: TextStyle(fontFamily: 'sans')),
                onPressed: () {},
              ),
            ),
            SizedBox(height: responsive.ip(2.0)),
            RoundedButton(
              label: 'Sign In',
              onPressed: () {},
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
                    _gotTo(context, user);
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
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
