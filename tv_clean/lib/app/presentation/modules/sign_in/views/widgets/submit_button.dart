import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/routes.dart';
import '../../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Provider.of(context); // listen = true
    if (controller.state.fetching) {
      const CircularProgressIndicator();
    }

    return MaterialButton(
      onPressed: () {
        final isValid = Form.of(context).validate();
        if (isValid) {
          _submit(context);
        }
      },
      color: Colors.blue,
      child: const Text('Sign in'),
    );
  }

  // _submit(context) => para el snackbar
  Future<void> _submit(BuildContext context) async {
    final SignInController controller = context.read();
    final result = await controller.submit();

    // Como se va a volver a usar 'context' en el Navigator, asegurar que vista sigue rendereizada
    /* if (!mounted) {
      return;
    } */
    // mounted solo funciona cuando es un statefullWidget
    // Para saber si widget sigue renderizado, usar el dispose del controlador
    if (!controller.mounted) {
      return;
    }

    result.when(
        left: (failure) {
          // Función anónima que se llame asímismo
          final message = failure.when(
              network: () => 'Network error',
              notFound: () => 'Not Found',
              unauthorized: () => 'Invalid Password',
              unknown: () => 'Error',
              notVerified: () => 'Email not verified');

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        },
        right: (_) => Navigator.pushReplacementNamed(context, Routes.home));
  }
}
