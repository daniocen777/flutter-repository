import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/colors.dart';
import '../widgets/back_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // StatusBar color whhite
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
    );
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                width: double.infinity,
                height: 350.0,
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: backButton(context, Colors.white),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(0.0, -20.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcom Back",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "Login to you account",
                          style: TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      _emailInput(),
                      _passwordInput(),
                      _loginButton(context),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, "forgot_password"),
                          child: Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't hace an account?",
                              style: TextStyle(
                                color: greyColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Form
Widget _emailInput() {
  return Container(
    padding: EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: bgInputs,
    ),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
}

Widget _passwordInput() {
  return Container(
    margin: EdgeInsets.only(top: 15.0),
    padding: EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: bgInputs,
    ),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
}

Widget _loginButton(BuildContext context) {
  return Container(
    width: 350.0,
    height: 45.0,
    margin: EdgeInsets.only(top: 30.0),
    child: ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, 'login'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: orange,
        elevation: 0.5,
      ),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
    ),
  );
}
