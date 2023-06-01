import 'package:flutter/material.dart';

/* dDiálogo que abre desde abajo hasta la mitad de la pantalla (por defecto) */
Future<void> showBottomSheetDialog(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.elliptical(20.0, 10.0),
      topRight: Radius.elliptical(20.0, 10.0),
    )),
    // Restringir para dispositivos largos
    constraints: const BoxConstraints(
      maxWidth: 480.0,
    ),
    builder: (BuildContext context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Para ocupar altura necesaria
        children: [
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Mis fotos'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.music_note),
                title: const Text('Mis Música'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.video_camera_back_outlined),
                title: const Text('Mis Videos'),
                onTap: () => Navigator.pop(context),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
