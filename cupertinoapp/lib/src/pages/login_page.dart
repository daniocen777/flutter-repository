import 'package:cupertinoapp/src/api/account_api.dart';
import 'package:cupertinoapp/src/pages/home_page.dart';
import 'package:cupertinoapp/src/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cupertinoapp/src/widgets/myButton_widget.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isFetching = false;
  GlobalKey<FormState> _formKey = GlobalKey();
  AccountApi _accountApi = AccountApi();

  @override
  void dispose() {
    _focusNodePassword.dispose();
    super.dispose();
  }

  _submit() async {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      setState(() {
        _isFetching = true;
      });
      bool isOk = await _accountApi.login(_email, _password);
      if (isOk) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('wasLogin', true);
        Navigator.pushReplacementNamed(context, HomePage.routename);
      } else {
        setState(() {
          _isFetching = false;
        });
        
        await Dialogs.alert(context,
            title: 'Error', body: 'Email y/o contraseña incorrectos');
      }
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

    return Scaffold(
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
                        padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
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
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              initialValue: 'eve.holt@reqres.in',
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.next,
                              validator: _validateEmail,
                              onFieldSubmitted: (String text) {
                                _focusNodePassword.nextFocus();
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Container(
                                    padding: EdgeInsets.all(10.0),
                                    width: 70.0,
                                    height: 40.0,
                                    child: WebsafeSvg.asset(
                                        'assets/icons/mail.svg'),
                                  ),
                                  hintText: 'ejemplo@mail.com',
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              obscureText: true,
                              focusNode: _focusNodePassword,
                              initialValue: 'cityslicka',
                              keyboardAppearance: Brightness.light,
                              validator: _validatePassword,
                              decoration: InputDecoration(
                                  prefixIcon: Container(
                                    padding: EdgeInsets.all(10.0),
                                    width: 70.0,
                                    height: 40.0,
                                    child: WebsafeSvg.asset(
                                        'assets/icons/password.svg'),
                                  ),
                                  hintText: '*********',
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              textInputAction: TextInputAction.send,
                              onFieldSubmitted: (String text) {
                                _submit();
                              },
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text('Recuperar contraseña',
                                          style: TextStyle(
                                              color: Colors.blueAccent[700])),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1.0,
                                                  color:
                                                      Colors.blueAccent[700]))),
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
          if (_isFetching)
            Positioned.fill(
                child: Container(
              color: Colors.white70,
              child: Center(
                  child: CupertinoActivityIndicator(
                radius: 15.0,
              )),
            ))
        ],
      )),
    );
  }
}
