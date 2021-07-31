import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../data/models/user.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../global_widgets/my_input_text.dart';
import '../../../utils/dialogs.dart';
import '../../../utils/font_style.dart';
import '../login_controller.dart';

class LoginForm extends StatelessWidget {
 /*  final GlobalKey<FormState> _formKey = GlobalKey(); */

  void _submit(BuildContext context) async {
    final controller = context.read<LoginController>();
   /*  final bool isValid = _formKey.currentState!.validate(); */
   /*  print('VALIDACIÓN: $isValid'); */

    if (true) {
      ProgressDialog.show(context); // Mostrar progress indicator
      Navigator.pop(context); // Cerrar el diálogos
      final User? user = await controller.submit();
      if (user == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('El correo o la contraseña son inválidos'),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Registros inválidos'),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<LoginController>(context, listen: false);
    return Form(
      
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 340.0),
        child: Column(
          children: [
            /* Correo */
            MyInputText(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Correo',
              validator: (text) {
                return text!.trim().contains('@') ? null : 'Correo inválido';
              },
              keyboardType: TextInputType.emailAddress,
              onChanged: _controller.onEmailChanged,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20.0),
            /* Contraseña */
            MyInputText(
              prefixIcon: Icon(Icons.lock_outline),
              labelText: 'Contraseña',
              obscureText: true,
              onChanged: _controller.onPasswordChanged,
              textInputAction: TextInputAction.send,
              onSubmitted: (text) => _submit(context),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CupertinoButton(
                  child: Text('¿Olvidaste tu contraseña?',
                      style: FontStyle.regular),
                  onPressed: () => print('LOGIN')),
            ),
            SizedBox(height: 20.0),
            RoundedButton(
                label: 'Login',
                fullWidth: false,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                onPressed: () => this._submit(context)),
          ],
        ),
      ),
    );
  }
}
