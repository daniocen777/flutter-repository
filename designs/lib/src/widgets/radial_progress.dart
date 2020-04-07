import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final porcentaje;
  final Color colorPrimario;
  final Color colorBorde;
  final double grosorprimario;
  final double grosorBorde;

  RadialProgress(
      {Key key,
      @required this.porcentaje,
      this.colorPrimario = Colors.blue,
      this.colorBorde = Colors.green,
      this.grosorprimario = 10.0,
      this.grosorBorde = 5.0})
      : super(key: key);

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double porcentajeAnterior;

  @override
  void initState() {
    super.initState();
    porcentajeAnterior = widget.porcentaje;
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: controller,
      //child: ,
      builder: (BuildContext context, Widget child) {
        return Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
              painter: _RadialProgress(
                  (widget.porcentaje - diferenciaAnimar) +
                      (diferenciaAnimar * controller.value),
                  widget.colorPrimario,
                  widget.colorBorde,
                  widget.grosorBorde,
                  widget.grosorprimario)),
        );
      },
    );
  }
}

class _RadialProgress extends CustomPainter {
  final porcentaje;
  final Color colorPrimario;
  final Color colorBorde;
  final double grosorprimario;
  final double grosorBorde;

  _RadialProgress(this.porcentaje, this.colorPrimario, this.colorBorde,
      this.grosorBorde, this.grosorprimario);

  @override
  void paint(Canvas canvas, Size size) {
    // Circunferencia
    final paint = Paint()
      ..strokeWidth = grosorBorde
      ..color = colorBorde
      ..style = PaintingStyle.stroke;

    //drawCircle(offset, radius, paint);
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radio = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radio, paint);

    // Arco
    final paintArco = Paint()
      ..strokeWidth = grosorprimario
      ..color = colorPrimario
      ..strokeCap = StrokeCap.round
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
