import 'package:flutter/material.dart';

import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/widgets/button_blue.dart';
import 'package:chatapp/widgets/custom_input.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  static final route = 'register';
  const RegisterPage({Key key}) : super(key: key);

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
                Logo(title: 'Register'),
                _Form(),
                Labels(
                    question: '¿Ya tienes una?',
                    action: 'Ingresa',
                    route: LoginPage.route),
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
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icon(Icons.person_outline),
            placeholder: 'Nombre',
            textEditingController: this.nameController,
          ),
          CustomInput(
            icon: Icon(Icons.mail_outline),
            placeholder: 'Correo',
            textInputType: TextInputType.emailAddress,
            textEditingController: this.emailController,
          ),
          CustomInput(
            icon: Icon(Icons.lock_outline),
            placeholder: 'Contraseña',
            isPassword: true,
            textEditingController: this.passwordController,
          ),
          SizedBox(height: 25.0),
          ButtonBlue(
            onPressed: () {
              print('CORREO ${this.emailController.text}');
              print('PASS ${this.passwordController.text}');
            },
            label: 'Registrar',
          ),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
}
