import 'package:cupertinoapp/src/widgets/login-text-form-field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cupertinoapp/src/widgets/myButton_widget.dart';

import 'package:cupertinoapp/src/blocs/login/login-bloc_exports.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static final routename = 'login';
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNodePassword = FocusNode();
  String _email = '';
  String _password = '';

  GlobalKey<FormState> _formKey = GlobalKey();

  /* Bloc */
  LoginBloc _loginBloc = LoginBloc();

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _loginBloc.close();
    super.dispose();
  }

  _submit() async {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      _loginBloc.add(LoginByPassword(
          context: context, email: _email, password: _password));
    }
  }

  String _validateEmail(String email) {
    if (email.isNotEmpty && email.contains('@')) {
      _email = email;
      return null;
    } else {
      return 'Invalid email';
    }
  }

  String _validatePassword(String password) {
    if (password.isNotEmpty && password.length > 5) {
      _password = password;
      return null;
    } else {
      return 'Invalid password';
    }
  }

  @override
  Widget build(BuildContext context) {
    /* final MediaQueryData mediaQueryData = MediaQuery.of(context); */
    /* final Size size = mediaQueryData.size;
    final EdgeInsets padding = mediaQueryData.padding; */

    return BlocProvider.value(
      value: _loginBloc,
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontFamily: "Signatra",
                                fontSize: 50.0,
                                color: Colors.blueAccent[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text('Ingrese sus datos',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 330.0, minHeight: 200.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40.0,
                              ),
                              LoginTextFormField(
                                iconPath: 'assets/icons/mail.svg',
                                hintText: 'ejemplo@mail.com',
                                labelText: 'Email',
                                initialValue: 'eve.holt@reqres.in',
                                validator: _validateEmail,
                                onFieldSubmitted: (String text) {
                                  _submit();
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              LoginTextFormField(
                                obscureText: true,
                                iconPath: 'assets/icons/password.svg',
                                hintText: '*********',
                                labelText: 'Password',
                                initialValue: 'cityslicka',
                                validator: _validatePassword,
                                focusNode: _focusNodePassword,
                                onFieldSubmitted: (String text) {
                                  _focusNodePassword.nextFocus();
                                },
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text('Recuperar contraseña',
                                            style: TextStyle(
                                                color: Colors.blueAccent[700])),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1.0,
                                                    color: Colors
                                                        .blueAccent[700]))),
                                      ),
                                      onPressed: () {}),
                                ],
                              ),
                              SizedBox(
                                height: 35.0,
                              ),
                              MyButton(
                                label: 'INGRESAR',
                                textColor: Colors.white,
                                fullWidth: true,
                                backgroundColor: Colors.blueAccent[700],
                                onPressed: _submit,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text('O, inicia con:'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MyButton(
                                      label: 'FACEBOOK',
                                      textColor: Colors.white,
                                      fullWidth: true,
                                      backgroundColor: Colors.blue[900],
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 15.0),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: MyButton(
                                      label: 'GOOGLE',
                                      textColor: Colors.white,
                                      fullWidth: true,
                                      backgroundColor: Colors.pinkAccent[400],
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.0, vertical: 15.0),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.0)
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (BuildContext context, state) {
                if (state.fetching) {
                  Positioned.fill(
                      child: Container(
                    color: Colors.white70,
                    child: Center(
                        child: CupertinoActivityIndicator(
                      radius: 15.0,
                    )),
                  ));
                }
                return Container();
              },
              // Sólo renderizar cuando el estado previo es distinto del nuevo<
              condition: (previousState, nextState) =>
                  previousState.fetching != nextState.fetching,
            )
          ],
        )),
      ),
    );
  }
}
