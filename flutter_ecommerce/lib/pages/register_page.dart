import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting, _obscureText = true;
  String _username, _email, _password;

  Widget _showTitle() {
    return Text(
      "Register",
      style: Theme.of(context).textTheme.headline,
    );
  }

  Widget _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _username = val,
        validator: (val) => val.length < 6 ? "Username is to short" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Username",
            hintText: "Enter username, min length 6",
            icon: Icon(
              Icons.face,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _email = val,
        validator: (val) => !val.contains("@") ? "Invalid email" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "Enter a valid email",
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _password = val,
        validator: (val) => val.length < 6 ? "password is to short" : null,
        obscureText: _obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password",
            hintText: "Enter password, min length 6 ",
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() => _obscureText = !_obscureText);
                },
                child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off)),
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor))
              : RaisedButton(
                  child: Text("Submit",
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Colors.black)),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Theme.of(context).primaryColor,
                  onPressed: _submit,
                ),
          FlatButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/login"),
              child: Text("Exiting user? Login"))
        ],
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
    } else {
      print("form INvalid");
    }
  }

  void _registerUser() async {
    setState(() => _isSubmitting = true);
    http.Response response = await http.post(
        "http://192.168.1.7:1337/auth/local/register",
        body: {"username": _username, "email": _email, "password": _password});

    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      _storeUserData(responseData);
      _showSuccessSnack();
      _redirectUser();
      print(responseData);
    } else {
      setState(() => _isSubmitting = false);
      final errorMessage = responseData["message"];
      _showErrorSnack(errorMessage);
    }
  }

  void _storeUserData(responseData) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData["user"];
    // Agrega una nueva propiedad al objeto user
    user.putIfAbsent("jwt", () => responseData["jwt"]);
    prefs.setString("user", json.encode(user));
  }

  _showSuccessSnack() {
    final snackbar = SnackBar(
        content: Text("User $_username successfully created!",
            style: TextStyle(color: Colors.green)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMessage) {
    final snackbar = SnackBar(
        content: Text(errorMessage, style: TextStyle(color: Colors.red)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    //throw Exception("Error registering: $errorMessage");
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _showTitle(),
                    _showUsernameInput(),
                    _showEmailInput(),
                    _showPasswordInput(),
                    _showFormActions()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
