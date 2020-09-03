import 'package:flutter/material.dart';
import 'package:googlemap/src/api/my_api.dart';
import 'package:googlemap/src/utils/responsive.dart';
import 'package:googlemap/src/widgets/input_text.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _username = '';
  String _email = '';
  String _password = '';

  _submit() async {
    final bool isOk = _formKey.currentState.validate();
    if (isOk) {
      MyApi myApi = MyApi();
      await myApi.register(context,
          username: _username, email: _email, password: _password);
    }
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
                label: 'Username',
                fontSize: responsive.dp(responsive.isTabled ? 1.2 : 1.4),
                onChanged: (text) {
                  _username = text;
                },
                validator: (value) {
                  if (value.trim().length < 5) {
                    return 'Invalid username';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'Email Address',
                fontSize: responsive.dp(responsive.isTabled ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text;
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
              InputText(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                label: 'Password',
                fontSize: responsive.dp(responsive.isTabled ? 1.2 : 1.4),
                onChanged: (text) {
                  _password = text;
                },
                validator: (value) {
                  if (value.trim().length < 6) {
                    return 'Invalid password';
                  }
                  return null;
                },
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
                    child: Text('Sign Up',
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
                    'Already have account?',
                    style: TextStyle(fontSize: responsive.dp(1.5)),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Sign In',
                          style: TextStyle(
                              fontSize: responsive.dp(1.5),
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.w600)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
