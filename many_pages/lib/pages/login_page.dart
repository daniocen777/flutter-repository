import 'package:flutter/material.dart';
import 'package:many_pages/constants/colors_const.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey(); // Validar formulario
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(size),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                  width: double.infinity,
                ),
                _crearLogo(),
                Form(
                  key: _key,
                  child: loginForm(context, size),
                ),
                SafeArea(
                  child: Container(height: 5.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fondoApp(Size size) {
    final gradiente = Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [primaryColor, thirdColor])),
    );

    return Stack(
      children: <Widget>[gradiente],
    );
  }

  Widget _crearLogo() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 160.0,
            height: 160.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/img/logo.gif'),
                )),
          ),
        ],
      ),
    );
  }

  Widget loginForm(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Ingreso",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: secondColor),
                ),
                SizedBox(height: 30.0),
                _crearUsuario(),
                SizedBox(height: 30.0),
                _crearPassword(),
                SizedBox(height: 30.0),
                _crearBoton(context),
                SizedBox(height: 30.0),
                irPaginaRecuperarPassword(),
                SizedBox(height: 20.0),
                registrarPorRedesSociales(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearUsuario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: "_usuario.usuario",
        decoration: InputDecoration(
            icon: Icon(
              Icons.person,
              color: secondColor,
            ),
            hintText: "Usuario Guilligan",
            labelText: "Usuario"),
        validator: (valor) {
          if (valor.length == 0) {
            return 'El usuario es requerido';
          } else if (valor != "dani") {
            return 'El usuario es incorrecto';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: "",
        obscureText: _obscureText,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: secondColor,
            ),
            suffixIcon: IconButton(
              icon: _obscureText == true
                  ? Icon(
                      Icons.visibility_off,
                      color: defaultColor,
                    )
                  : Icon(
                      Icons.visibility,
                    ),
              onPressed: () => _toggle(),
            ),
            labelText: "Contraseña"),
        validator: (valor) {
          if (valor != "123") {
            return "La contraseña es incorrecta";
          } else {
            return null;
          }
        },
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text("Ingresar"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 1.0,
      color: secondColor,
      textColor: Colors.white,
      onPressed: () {
      },
    );
  }

  Widget irPaginaRecuperarPassword() {
    return FlatButton(
      child: Text(
        '¿Olvidaste tu contraseña?',
        style: TextStyle(decoration: TextDecoration.underline),
      ),
      textColor: Colors.blueAccent,
      onPressed: () {},
    );
  }

  Widget registrarPorRedesSociales() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 70.0,
          child: FlatButton(
            child: Image.asset('assets/img/face.png'),
            textColor: Colors.blueAccent,
            onPressed: () {},
          ),
        ),
        Container(
          width: 70.0,
          child: FlatButton(
            child: Image.asset('assets/img/gmail.png'),
            textColor: Colors.blueAccent,
            onPressed: () {},
          ),
        ),
        Container(
          width: 70.0,
          child: FlatButton(
            child: Image.asset('assets/img/aple.png'),
            textColor: Colors.blueAccent,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
