import 'package:flutter/material.dart';
import 'package:my_widgets/dialogs/bottom_sheet_dialog.dart';
import 'package:my_widgets/dialogs/confirm_dialog.dart';
import 'package:my_widgets/dialogs/cupertino_dialog.dart';
import 'package:my_widgets/dialogs/custom_dialog.dart';

class DialogsPage extends StatelessWidget {
  const DialogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text('INFO Dialog'),
            onTap: () {
              // context es el contexto de widget Dialog, NO del de arriba (página)
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const DialogContent());
            },
          ),
          ListTile(
            title: const Text('INFO CONFIRM Dialog'),
            onTap: () async {
              // context es el contexto de widget Dialog, NO del de arriba (página)
              final isOK = await showConfirmDialog(
                context,
                title: '¿Está seguro?',
                dismissable: false,
              );
              print(isOK);
            },
          ),
          ListTile(
            title: const Text('CUPERTINO Dialog'),
            onTap: () async {
              final value = await showDialogWithCupertinoStyle(context,
                  title: 'Cupertino Dialog', content: 'Mi diálogo');
              print(value);
            },
          ),
          ListTile(
            title: const Text('BOTTOM SHEET Dialog'),
            onTap: () async {
              showBottomSheetDialog(context);
            },
          ),
          ListTile(
            title: const Text('CUSTOM Dialog'),
            onTap: () async {
              showCustomDialog(context);
            },
          )
        ],
      ),
    );
  }
}

class DialogContent extends StatelessWidget {
  const DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('My Dialog'),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    );
  }
}
