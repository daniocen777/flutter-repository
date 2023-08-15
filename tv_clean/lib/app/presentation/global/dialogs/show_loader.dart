import 'package:flutter/material.dart';

Future<T> showLoader<T>(BuildContext context, Future<T> future) async {
  final overlayState = Overlay.of(context); // Widget Overlay
  final entry = OverlayEntry(
    builder: (_) => Container(
      color: Colors.black45,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );

  overlayState.insert(entry);

  final result = await future;
  entry.remove(); // eliminar el overlay
  return result;
}
