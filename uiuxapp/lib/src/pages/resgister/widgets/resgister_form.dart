import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uiuxapp/src/routes/routes.dart';

import '../../../pages/resgister/register_controller.dart';
import '../../../utils/dialogs.dart';
import '../../../global_widgets/rounded_button.dart';
import '../../../global_widgets/my_input_text.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit(BuildContext context) async {
    /* Validar si los campos son correctos */
    final controller = context.read<RegisterController>();
    final bool? isOk = await controller.submit();
    final bool isValid = _formKey.currentState!.validate();
    print('VALIDACIÓN: $isValid');

    if (isValid) {
      ProgressDialog.show(context); // Mostrar progress indicator
      Navigator.pop(context); // Cerrar el diálogos
      if (!isOk!) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('El registro falló'),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                  child: AlertDialog(
                    title: Text('¡Correcto!'),
                    content: Text('Ahora ya puede ingresar'),
                    actions: [
                      TextButton(
                          /* Navigator.popUntil => Cerrar todo e ir a Login */
                          onPressed: () => Navigator.popUntil(context,
                              (route) => route.settings.name == Routes.LOGIN),
                          child: Text('Ok'))
                    ],
                  ),
                  onWillPop: () async => false);
            });
      }
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

  @override
  Widget build(BuildContext context) {
    final _controller = context.watch<RegisterController>();
    return Form(
      key: _formKey,
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 340.0),
          child: Column(
            children: [
              MyInputText(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Nombre',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (text) {
                  return text!.trim().length > 1 ? null : 'Nombre inválido';
                },
                onChanged: _controller.onNameChanged,
              ),
              SizedBox(height: 20.0),
              MyInputText(
                prefixIcon: Icon(Icons.person_add_outlined),
                labelText: 'Apellido',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                validator: (text) {
                  return text!.trim().length > 1 ? null : 'Apellido inválido';
                },
                onChanged: _controller.onLastnameChanged,
              ),
              SizedBox(height: 20.0),
              MyInputText(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Correo',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                validator: (text) {
                  return text!.trim().contains('@') ? null : 'Correo inválido';
                },
                onChanged: _controller.onEmailChanged,
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: RoundedButton(
                    label: 'Registrar',
                    fullWidth: false,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                    onPressed: () {
                      this._submit(context);
                    }),
              ),
            ],
          )),
    );
  }
}
