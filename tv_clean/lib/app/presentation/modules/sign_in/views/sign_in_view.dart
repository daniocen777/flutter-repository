import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/sign_in_controller.dart';
import 'widgets/submit_button.dart';

class SigInView extends StatelessWidget {
  const SigInView({super.key});

  @override
  Widget build(BuildContext context) {
    /*  Widget ChangeNotifierProvider para escuchar los cambios (se usa cuando se trabaja con
    una clase que extienda de ChangeNotifier) */
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(),
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Builder(builder: (context) {
              // para escuchar klos cambios (listen = true => por defecto)
              final controller =
                  Provider.of<SignInController>(context, listen: true);
              // AbsorbPointer => Para bloquear widget
              return AbsorbPointer(
                absorbing: controller.fetching,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) {
                        controller.onUsernameChanged(text);
                      },
                      decoration: const InputDecoration(hintText: 'Username'),
                      validator: (text) {
                        text = text?.trim().toLowerCase() ?? '';
                        if (text.isEmpty) {
                          return 'Invalid username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) {
                        controller.onPasswordChanged(text);
                      },
                      decoration: const InputDecoration(hintText: 'Password'),
                      validator: (text) {
                        text = text?.replaceAll(' ', '') ?? '';
                        if (text.length < 4) {
                          return 'Invalid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const SubmitButton()
                  ],
                ),
              );
            }),
          ),
        ),
      )),
    );
  }
}
