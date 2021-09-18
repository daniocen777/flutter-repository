import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../witgets/sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = new Responsive.of(context);
    return Theme(
        data: ThemeData(
            primaryColor: primaryColor,
            backgroundColor: accentColor,
            brightness: Brightness.light,
            accentColor: accentColor,
            focusColor: primaryColor,
            hoverColor: primaryColor,
            splashColor: primaryColor
            ),
        child: Scaffold(
            body: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40.0,
                                    ),
                                    Text('Welcome!',
                                        style: TextStyle(
                                            fontSize: responsive.ip(5.0),
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(height: 20.0),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Please, provide following',
                                              style: TextStyle(
                                                fontSize: responsive.ip(2.0),
                                              )),
                                          Text('details for your new account',
                                              style: TextStyle(fontSize: 15))
                                        ]),
                                    SizedBox(height: 30.0),
                                    SignUpForm()
                                  ])))
                    ]))));
  }
}
