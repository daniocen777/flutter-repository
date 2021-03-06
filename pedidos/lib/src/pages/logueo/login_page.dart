import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  Widget _showTitle() {
    return Text(
      "Login",
      style: Theme.of(context).textTheme.headline,
    );
  }

  Widget _showUserInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        //onSaved: (val) => _email = val,
        validator: (val) => val.length < 4 ? "Usuario muy corto" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Usuario",
            hintText: "Ingrese usurio",
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
        //onSaved: (val) => _password = val,
        validator: (val) =>
            val.length < 6 ? "Contraseña de más de 6 caracteres" : null,
        obscureText: _obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Contraseña",
            hintText: "Ingrese contraseña. Más de 6 caracteres",
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
            child: Text("Ingresar",
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.black)),
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Theme.of(context).accentColor,
            onPressed: _submit,
          ),
          /* FlatButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "register"),
              child: Text("¿Eres nuevo? Registrar")) */
        ],
      ),
    );
  }

  void _submit() {
    Navigator.pushReplacementNamed(context, "home");
    /* final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    } else {
      print("form INvalid");
    } */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _showTitle(),
                    _showUserInput(),
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
