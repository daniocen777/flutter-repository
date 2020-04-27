import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_avanzado/src/pages/login/widgets/login_form.dart';
import 'package:login_avanzado/src/pages/login/widgets/welcome.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            /* MainAxisAlignment.spaceBetween => widgets lo más separados que se pueda */
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[Welcome(), LoginForm()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
