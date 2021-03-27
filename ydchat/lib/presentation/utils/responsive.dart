import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width;
  final double height;
  final double inch; // Diagonal

  Responsive({required this.width, required this.height, required this.inch});

  // Factory
  factory Responsive.of(BuildContext context) {
    final data = MediaQuery.of(context);
    final size = data.size;
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  // Porcentaje del ancho de la pantalla
  double wp(double porcent) {
    return this.width * porcent / 100;
  }

  // Porcentaje de la altura de la pantalla
  double hp(double porcent) {
    return this.height * porcent / 100;
  }

  // Porcentaje de la diagonal de la pantalla
  double ip(double porcent) {
    return this.inch * porcent / 100;
  }
}
