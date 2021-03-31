import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/labels.dart';
import '../widgets/common/title.dart';
import '../utils/dialogs.dart';
import '../screens/register_screen.dart';
import '../screens/chat_screen.dart';

class AuthScreen extends StatelessWidget {
  static final String route = 'auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleWidget(titulo: 'Iniciar Sesión'),
                    SizedBox(
                      height: 10.0,
                    ),
                    _Form(),
                    Labels(
                      ruta: RegisterScreen.route,
                      pregunta: '¿No tienes cuenta?',
                      accion: 'Crea una cuenta aquí',
                    ),
                  ],
                ),
              )),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: [
          CustomTextField(
            textEditingController: emailController,
            keyboardType: TextInputType.emailAddress,
            icon: Icons.mail,
            hintText: 'Correo',
          ),
          CustomTextField(
            textEditingController: passwordController,
            obscureText: true,
            icon: Icons.lock,
            hintText: 'Contraseña',
          ),
          SizedBox(height: 20.0),
          CustomButton(text: 'Ingresar', onPressed: _submitAuth)
        ],
      ),
    );
  }

  void _submitAuth() async {
    try {
      UserCredential userCredential = await this
          ._auth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      if (userCredential.user?.email != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.route);
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Ha ocurrido un error';
      if (e.code == 'user-not-found') {
        message = 'El usuario no existe';
      } else if (e.code == 'wrong-password') {
        message = 'La contraseña es incorrecta';
      }

      await Dialogs.alert(context, title: 'Error', body: message);
    }
  }
}
