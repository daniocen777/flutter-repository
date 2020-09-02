import 'package:flutter/material.dart';
import 'package:googlemap/src/pages/login/register_page.dart';
import 'package:googlemap/src/utils/responsive.dart';
import 'package:googlemap/src/widgets/input_text.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '';
  String _password = '';

  _submit() {
    final bool isOk = _formKey.currentState.validate();
    if (isOk) {}
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    /* Si el Positioned no está dentro de un Stack, necesita del left y right 
    o un BoxConstraints */
    return Positioned(
      bottom: 10.0,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: responsive.isTabled ? 430.0 : 260.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'Email Address',
                fontSize: responsive.dp(responsive.isTabled ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
                  print('email: $text');
                },
                validator: (value) {
                  if (!value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputText(
                        obscureText: true,
                        label: 'Password',
                        borderEnabled: false,
                        fontSize:
                            responsive.dp(responsive.isTabled ? 1.2 : 1.4),
                        onChanged: (text) {
                          _password = text;
                          print('password: $text');
                        },
                        validator: (value) {
                          if (value.trim().length == 0) {
                            return 'Invalid password';
                          }
                          return null;
                        },
                      ),
                    ),
                    FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        onPressed: () {},
                        child: Text('Forgot password',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: responsive
                                    .dp(responsive.isTabled ? 1.2 : 1.5)))),
                  ],
                ),
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    onPressed: this._submit,
                    color: Colors.pinkAccent,
                    child: Text('Sign In',
                        style: TextStyle(
                            fontSize: responsive.dp(1.5),
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New to friendly desi?',
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterPage.route);
                      },
                      child: Text('Sign Up',
                          style: TextStyle(
                              fontSize: responsive.dp(1.5),
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.w600)))
                ],
              ),
              SizedBox(
                height: responsive.dp(10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
