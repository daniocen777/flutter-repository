import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(BuildContext context,
    {String title = '', bool dismissable = true}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierColor: Colors.white.withOpacity(0.8), // color fuera del diálogo
    //  barrierDismissible: false, // No cerrar diálogo al hacer tap fuera de él (WillPopScope ya lo hace)
    builder: (BuildContext context) => WillPopScope(
        child: _DialogContent(
          title: title,
        ),
        onWillPop: () async => dismissable),
  );
  return result ?? false;
}

class _DialogContent extends StatelessWidget {
  final String title;
  const _DialogContent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // WillPopScope => Evitar la acción del botón de regreso de android
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center, // lugar de los botones
      alignment: Alignment.bottomCenter, // lugar donde está el diálogo
      elevation: 10.0, // sombra del díalogo
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      actions: [
        // Pasar true junto al contexto en el Navigator para capturar la respuesta
        MaterialButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            'Sí',
            style: TextStyle(color: Colors.green),
          ),
        ),
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
