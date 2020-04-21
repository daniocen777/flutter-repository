import 'package:flutter/material.dart';

class BotonNaranja extends StatelessWidget {
  final String texto;
  final double alto;
  final double ancho;
  final Color color;

  const BotonNaranja(
      {Key key,
      @required this.texto,
      this.alto = 50.0,
      this.ancho = 140.0,
      this.color = Colors.deepOrange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.ancho,
      height: this.alto,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0), color: this.color),
      child: Text('$texto',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
