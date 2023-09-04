import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  const SnackbarScreen({super.key});

  static const name = 'snackbar_screen';

  void showCustomSnackbar(BuildContext context) {
    // Limpiar los snackbars anteriores (al presionar botón varias veces)
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: const Text('Holas mundos'),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ),
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false, // obligar a seleccionar un botón
        builder: (BuildContext context) => AlertDialog(
              title: const Text('¿Estás seguro?'),
              content: const Text(
                  'Commodo enim non consequat sit enim amet commodo consectetur labore et consectetur eiusmod irure. Culpa fugiat non ad enim reprehenderit laborum dolore excepteur mollit qui sint deserunt incididunt proident. Occaecat ea dolore mollit ipsum ex laboris ullamco nisi.'),
              actions: [
                TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancelar')),
                FilledButton(
                    onPressed: () => context.pop(),
                    child: const Text('Aceptar')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar y diálogos'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar snacbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () => showAboutDialog(context: context, children: [
                const Text(
                    'Sint minim dolor quis sit labore esse mollit exercitation. Exercitation elit eu quis anim exercitation irure quis esse ut sint velit pariatur anim. Amet sint aute dolore ea nulla incididunt.')
              ]),
              child: const Text('Licencias usadas'),
            ),
            FilledButton.tonal(
              onPressed: () => openDialog(context),
              child: const Text('Mostrar diálogo'),
            ),
          ],
        ),
      ),
    );
  }
}
