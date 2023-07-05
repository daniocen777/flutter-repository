import 'package:flutter/material.dart';
import 'package:my_widgets/pages/forms/login_mixin.dart';
import 'package:my_widgets/pages/forms/widgets/login_checkbox.dart';

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({super.key});

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> with LoginMixin {
  String _email = '';
  String _password = '';
  bool _checked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool allowSubmit = emailValidator(_email) == null;
    if (allowSubmit) {
      allowSubmit = passwordValidator(_password) == null;
    }
    // GestureDetector para minimizar teclado en ios (ver Main)
    return Form(
      key: _formKey,
      child: Scaffold(
          body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            TextFormField(
              /* initialValue: 'test@test.com', */
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (text) {
                setState(() {
                  _email = text.trim();
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              validator: emailValidator,
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  _password = value.replaceAll(' ', '');
                });
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
              validator: passwordValidator,
            ),
            const SizedBox(height: 30.0),
            LoginCheckbox(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                setState(
                  () {
                    _checked = value;
                  },
                );
              },
              validator: checkboxValidaotr,
            ),
            ElevatedButton(
              onPressed: allowSubmit ? submit : null,
              child: const Text('Sign In'),
            )
          ],
        ),
      )),
    );
  }

  void submit() {
    if (_formKey.currentState!.validate()) {}
  }
}
