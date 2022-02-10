import 'package:flutter/cupertino.dart';

Future<String?> showInputDialog(BuildContext context,
    {String? title, String? initialValue}) async {
  String value = initialValue ?? '';
  TextEditingController textEditingController = TextEditingController();
  textEditingController.text = value;
  final result = await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: CupertinoTextField(
              controller: textEditingController,
              onChanged: (text) {
                value = text;
              },
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Guardar'),
                isDefaultAction: true,
                onPressed: () {
                  // Cerrar diálogo y result tendrá el valor de "value"
                  Navigator.pop(context, value);
                },
              ),
              CupertinoDialogAction(
                child: const Text('Cancelar'),
                isDefaultAction: true,
                onPressed: () {
                  // Cerrar diálogo y result tendrá el valor de "value"
                  Navigator.pop(context);
                },
              )
            ],
          ));

  // Libear controldor
  textEditingController.dispose();

  if (result != null && result.trim().isEmpty) {
    return null; // Devolver null si result son espacios en blanco
  }
  return result;
}
