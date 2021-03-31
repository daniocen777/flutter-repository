import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_textfield.dart';
import '../widgets/common/labels.dart';
import '../widgets/common/title.dart';
import '../utils/dialogs.dart';
import '../screens/auth_screen.dart';
import '../screens/chat_screen.dart';

class RegisterScreen extends StatelessWidget {
  static final String route = 'register';

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
                  TitleWidget(titulo: 'Registro'),
                  SizedBox(
                    height: 10.0,
                  ),
                  _Form(),
                  Labels(
                    ruta: AuthScreen.route,
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
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nombreController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 45.0),
      child: Column(
        children: [
          CustomTextField(
            textEditingController: nombreController,
            icon: Icons.person,
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
          CustomButton(text: 'Registrar', onPressed: _submitRegister)
        ],
      ),
    );
  }

  void _submitRegister() async {
    try {
      UserCredential userCredential = await this
          ._auth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      await users.doc(userCredential.user!.uid).set({
        'username': nombreController.text.trim(),
        'email': emailController.text.trim()
      }).catchError((onError) async {
        await Dialogs.alert(context, title: 'Error', body: '$onError');
      });

      if (userCredential.user?.email != null) {
        Navigator.pushReplacementNamed(context, ChatScreen.route);
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Ha ocurrido un error';
      if (e.code == 'weak-password') {
        message = 'La contraseña es muy débil';
      } else if (e.code == 'email-already-in-use') {
        message = 'Este correo ya está registrado';
      }
      await Dialogs.alert(context, title: 'Error', body: message);
    } catch (e) {
      print('****************************** $e ******************************');
    }
  }
}
