import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/flutter_meedu.dart';

import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:authapp/app/ui/pages/register/utils/send_register_form.dart';
import 'package:authapp/app/ui/pages/register/controller/register_controller.dart';
import 'package:authapp/app/ui/pages/register/controller/register_state.dart';
import 'package:authapp/app/ui/global_widgets/custom_input_field.dart';
import 'package:authapp/app/utils/email_validator.dart';
import 'package:authapp/app/utils/name_validator.dart';

/* Para el estado */
final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent, // color para que funcione onTap
              child: Form(
                key: controller.formKey,
                child: ListView(
                  padding: const EdgeInsets.all(15.0),
                  children: [
                    CustomInputField(
                      label: 'Nombre',
                      validator: (text) {
                        return isValidName(text!) ? null : 'Nombre inválido';
                      },
                      onChanged: controller.onNameChanged,
                    ),
                    const SizedBox(height: 15.0),
                    CustomInputField(
                      label: 'Apellido',
                      validator: (text) {
                        return isValidName(text!) ? null : 'Apellido inválido';
                      },
                      onChanged: controller.onlastNameChanged,
                    ),
                    const SizedBox(height: 15.0),
                    CustomInputField(
                      label: 'Email',
                      inputType: TextInputType.emailAddress,
                      validator: (text) {
                        return isValidEmail(text!) ? null : 'Correo inválido';
                      },
                      onChanged: controller.onEmailChanged,
                    ),
                    const SizedBox(height: 15.0),
                    CustomInputField(
                      label: 'Password',
                      isPassword: true,
                      validator: (text) {
                        if (text!.trim().length >= 6) {
                          return null;
                        }
                        return 'Contraseña con al menos 5 caracteres';
                      },
                      onChanged: controller.onPasswordChanged,
                    ),
                    const SizedBox(height: 15.0),
                    /* Se necesita escuchar los cambios del password */
                    Consumer(builder:
                        (BuildContext context, BuilderRef ref, Widget? child) {
                      /* Cuando cambie el estado del campo password en
                              RegisterController, se redibuja este campo */
                      ref.watch(
                          registerProvider.select((state) => state.password));
                      return CustomInputField(
                          label: 'Verification Password',
                          isPassword: true,
                          validator: (text) {
                            if (text!.trim().length >= 6) {
                              return null;
                            }
                            if (controller.state.password != text) {
                              return "Las contraseñas no coinciden";
                            }
                            return "Contraseña con al menos 5 caracteres";
                          },
                          onChanged: controller.onVerifyPasswordChanged);
                    }),
                    const SizedBox(height: 30.0),
                    CupertinoButton(
                        child: const Text('Registrar'),
                        color: Colors.blue,
                        onPressed: () => sendRegisterForm(context))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
