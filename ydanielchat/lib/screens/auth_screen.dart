import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ydanielchat/utils/colors.dart';
import 'package:ydanielchat/utils/dialogs.dart';
import 'package:ydanielchat/widgets/login_text_form_field.dart';
import 'package:ydanielchat/widgets/my_button.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FocusNode _focusNodePassword = FocusNode();
  FirebaseAuth _auth = FirebaseAuth.instance;
  
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  String _username = '';
  String _email = '';
  String _password = '';
  bool _isLogin = true;
  bool _isLoading = false;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _focusNodePassword.dispose();

    super.dispose();
  }

  _submit() async {
    final bool isValid = _formKey.currentState.validate();
    if (isValid) {
      UserCredential userCredential;
      try {
        setState(() {
          _isLoading = true;
        });
        if (_isLogin) {
          userCredential = await this._auth.signInWithEmailAndPassword(
              email: this._email.trim(), password: this._password.trim());
        } else {
          userCredential = await _auth.createUserWithEmailAndPassword(
              email: this._email.trim(), password: this._password.trim());
        }
        await _users.doc(userCredential.user.uid).set({
          'username': this._username,
          'email': this._email,
        });
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        String message = 'Ha ocurrido un error';
        if (e.code == 'weak-password') {
          message = 'La contraseña es muy débil';
        } else if (e.code == 'email-already-in-use') {
          message = 'El correo está registrado';
        }
        await Dialogs.alert(context, title: 'Error', body: message);
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print('ERROR ===> $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _validateEmail(String email) {
    if (email.isNotEmpty && email.contains('@')) {
      _email = email;
      return null;
    } else {
      return 'Correo inválido';
    }
  }

  String _validatePassword(String password) {
    if (password.isNotEmpty && password.length > 5) {
      _password = password;
      return null;
    } else {
      return '6 caracteres como mínimo';
    }
  }

  String _validateUsername(String username) {
    if (username.isNotEmpty && username.length > 3) {
      _username = username;
      return null;
    } else {
      return '4 caracteres como mínimo';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          "Chat Privado",
                          style: TextStyle(
                              fontFamily: "Signatra",
                              fontSize: 50.0,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text('Ingrese sus datos',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600))
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
                            if (!_isLogin)
                              LoginTextFormField(
                                valueKey: ValueKey('username'),
                                iconPath: 'assets/images/shield.svg',
                                labelText: 'Nombre de Usuario',
                                validator: _validateUsername,
                                onFieldSubmitted: (String text) {
                                  _submit();
                                },
                              ),
                            SizedBox(
                              height: 20.0,
                            ),
                            LoginTextFormField(
                              valueKey: ValueKey('email'),
                              iconPath: 'assets/images/mail.svg',
                              textInputType: TextInputType.emailAddress,
                              hintText: 'ejemplo@mail.com',
                              labelText: 'Email',
                              validator: _validateEmail,
                              onFieldSubmitted: (String text) {
                                _submit();
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            LoginTextFormField(
                              valueKey: ValueKey('password'),
                              obscureText: true,
                              iconPath: 'assets/images/password.svg',
                              hintText: '*********',
                              labelText: 'Contraseña',
                              validator: _validatePassword,
                              focusNode: _focusNodePassword,
                              onFieldSubmitted: (String text) {
                                _focusNodePassword.nextFocus();
                              },
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            this._isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyButton(
                                        label: _isLogin
                                            ? 'Ingresar'
                                            : 'Crear cuenta',
                                        textColor: Colors.white,
                                        fullWidth: true,
                                        backgroundColor: primaryColor,
                                        onPressed: _submit,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          CupertinoButton(
                                              padding: EdgeInsets.zero,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10.0),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Text(
                                                    _isLogin
                                                        ? 'Crear una cuenta'
                                                        : 'Ya tengo una cuenta',
                                                    style: TextStyle(
                                                        color:
                                                            accentDarkColor)),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 1.0,
                                                            color: Colors
                                                                    .blueAccent[
                                                                700]))),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isLogin = !_isLogin;
                                                });
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text('O, inicia con:'),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print('INGRESANDO CON GOOGLE');
                                        },
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 250.0,
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/google_signin_button.png'),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
