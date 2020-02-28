import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
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
          RaisedButton(
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

  void _registerUser() {
    print("Antes del POST");
    http.post("http://127.0.0.1:1337/auth/local/register", body: {
      "username": _username,
      "email": _email,
      "password": _password
    }).then((response) {
      print("******** response ********");
      print(response);

      final responseData = json.decode(response.body);
      print("Esperando respuesta");
      print(responseData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
