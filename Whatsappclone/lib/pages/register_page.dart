import 'package:Whatsappclone/pages/login_page.dart';
import 'package:Whatsappclone/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:Whatsappclone/widgets/custom_textfield.dart';
import 'package:Whatsappclone/widgets/labels.dart';
import 'package:Whatsappclone/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  static String route = 'login';

  const RegisterPage({Key key}) : super(key: key);

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
                  Logo(titulo: 'Registro'),
                  _Form(),
                  Labels(
                    ruta: LoginPage.route,
                    pregunta: '¿Ya tienes una cuenta?',
                    accion: 'Ir a login',
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: [
          CustomTextField(
            textEditingController: nombreController,
            icon: Icons.perm_identity,
            hintText: 'Nombre',
          ),
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
          CustomButton(
              text: 'Ingresar',
              onPressed: () {
                print('Correo: ${emailController.text}');
                print('Contraseña: ${passwordController.text}');
              })
        ],
      ),
    );
  }
}
