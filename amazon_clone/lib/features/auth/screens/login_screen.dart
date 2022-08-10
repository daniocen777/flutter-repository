import 'package:amazon_clone/utils/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:amazon_clone/global_widgets/custom_input_field.dart';
import 'package:amazon_clone/global_widgets/rounded_button.dart';

class LoginScreen extends StatelessWidget {
  static const String route = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.read<AuthBloc>();
    GlobalKey<FormState> _formKey = GlobalKey();
    String email = '';
    String password = '';

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        return Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SingleChildScrollView(
                child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 330.0, minHeight: 200.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomInputField(
                              label: "Email",
                              onChanged: (text) {
                                email = text;
                              },
                              validator: (text) {
                                if (isValidEmail(text!)) {
                                  return null;
                                } else {
                                  return "Correo inválido";
                                }
                              }),
                          const SizedBox(height: 20.0),
                          CustomInputField(
                              label: "Contraseña",
                              isPassword: true,
                              onChanged: (text) {
                                password = text;
                              },
                              validator: (text) {
                                if (text!.length > 5) {
                                  return null;
                                } else {
                                  return "Debe ingresar contraseña";
                                }
                              }),
                          const SizedBox(height: 20.0),
                          RoundedButton(
                            text: "Ingresar",
                            diabled: state.loading ? true : false,
                            onPressed: () {
                              bool formValidate =
                                  _formKey.currentState!.validate();
                              if (formValidate) {
                                authBloc.add(LoginEvent(email, password));
                              }
                            },
                          )
                        ],
                      )))
            ])));
      },
    );
  }
}
