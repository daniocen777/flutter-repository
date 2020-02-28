import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  Widget _showTitle() {
    return Text(
      "Registro",
      style: Theme.of(context).textTheme.headline,
    );
  }

  Widget _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        //onSaved: (val) => _username = val,
        validator: (val) => val.length < 6 ? "EL usuario es muy corto" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Usuario",
            hintText: "Ingrese usuario. Mínimo de 6 caracteres",
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showNameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        //onSaved: (val) => _username = val,
        validator: (val) => val.length < 6 ? "El nombre es muy corto" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nombre",
            hintText: "Ingrese nombre. Mínimo de 6 caracteres",
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
        //onSaved: (val) => _email = val,
        validator: (val) => !val.contains("@") ? "Correo inválido" : null,
        keyboardType: TextInputType.emailAddress,
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
        //onSaved: (val) => _password = val,
        validator: (val) => val.length < 6 ? "password is to short" : null,
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
            child: Text("Registrar",
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
              onPressed: () => Navigator.pushReplacementNamed(context, "login"),
              child: Text("¿Eres usuario? Login"))
        ],
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    } else {
      print("Formulario inválido");
    }
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
                    _showUsernameInput(),
                    _showNameInput(),
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
