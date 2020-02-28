import 'package:flutter/material.dart';

// Mensajes
void mensajeConfirmacion(BuildContext context, String mensaje) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 2000),
      content: Text(mensaje),
      action: SnackBarAction(
          label: 'Cerrar', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
