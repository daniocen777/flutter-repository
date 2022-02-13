import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dark_mode_extension.dart';

Future<String?> showInputDialog(BuildContext context,
    {String? title, String? initialValue}) async {
  String value = initialValue ?? '';
  final isDarkMode = context.isThemeDarkMode;
  final result = await showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: CupertinoTextField(
              controller: TextEditingController()..text = initialValue ?? '',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: isDarkMode ? const Color(0xff29434e) : Colors.black12),
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

  if (result != null && result.trim().isEmpty) {
    return null; // Devolver null si result son espacios en blanco
  }
  return result;
}
