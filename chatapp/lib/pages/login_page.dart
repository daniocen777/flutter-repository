import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/widgets/button_blue.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  static final route = 'login';
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(title: 'Messenger'),
                _Form(),
                Labels(
                    question: '¿No tienes una cuenta?',
                    action: 'Crea una aquí',
                    route: RegisterPage.route),
                SizedBox(height: 25.0),
                Text('Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200)),
                SizedBox(height: 25.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* Formulario */
class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icon(Icons.mail_outline),
            placeholder: 'Correo',
            textInputType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          CustomInput(
            icon: Icon(Icons.lock_outline),
            placeholder: 'Contraseña',
            isPassword: true,
            textEditingController: passwordController,
          ),
          SizedBox(height: 25.0),
          ButtonBlue(
            onPressed: () {
              print('CORREO ${emailController.text}');
              print('PASS ${passwordController.text}');
            },
            label: 'Ingresar',
          ),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
}
