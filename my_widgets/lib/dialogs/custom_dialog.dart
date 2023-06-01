import 'package:flutter/material.dart';

Future<void> showCustomDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => const _CustomDialog());
}

class _CustomDialog extends StatelessWidget {
  const _CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        child: SizedBox(
          width: 360.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    size: 30.0,
                  ),
                ),
              ),
              const Text(
                'Felicidades',
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              const SizedBox(height: 15.0),
              const Icon(
                Icons.emoji_emotions_outlined,
                color: Colors.greenAccent,
                size: 100.0,
              ),
              const Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo',
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
