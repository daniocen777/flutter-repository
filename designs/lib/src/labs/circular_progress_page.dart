import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  CircularProgressPage({Key key}) : super(key: key);

  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double porcentaje = 0.0;
  double nuevoPorcentaje = 0.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    controller.addListener(() {
      // valor de controller va de 0 (comienza animación) a 1 (termina animación)
      /* print('Valor controller: ${controller.value}'); */
      setState(() {
        porcentaje = lerpDouble(porcentaje, nuevoPorcentaje,
            controller.value); // Interpolar dos números
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          backgroundColor: Colors.pinkAccent,
          onPressed: () {
            porcentaje = nuevoPorcentaje;
            nuevoPorcentaje += 10;
            if (nuevoPorcentaje > 100) {
              nuevoPorcentaje = 0;
              porcentaje = 0;
            }
            controller.forward(from: 0.0); // Inicio de aniamción

            setState(() {});
          }),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(5.0),
        width: 300.0,
        height: 300.0,
        child: CustomPaint(
          painter: _RadialProgress(porcentaje: porcentaje),
        ),
      )),
    );
  }
}

class _RadialProgress extends CustomPainter {
  final porcentaje;
  _RadialProgress({this.porcentaje});

  @override
  void paint(Canvas canvas, Size size) {
    // Circunferencia
    final paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    //drawCircle(offset, radius, paint);
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);

    // Arco
    final paintArco = Paint()
      ..strokeWidth = 10
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.stroke;
    double arcAngle = 2 * pi * (porcentaje / 100);
    // Dibujando el arco
    // drawArc(rect, startAngle, sweepAngle [ángulo de llenado], useCenter, paint)
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio), -pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
