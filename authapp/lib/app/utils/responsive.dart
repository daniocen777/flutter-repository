import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width;
  final double height;
  final double inch; // Diagonal
  final double? padding;

  Responsive(
      {required this.width,
      required this.height,
      required this.inch,
      this.padding});

  factory Responsive.fromSize(Size size) {
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(
        width: size.width,
        height: size.height,
        inch: inch,
        padding: data.padding.top + data.padding.bottom);
  }

  /*  Function(double) => double:
      input => porcentaje: Porcentaje del ancho que se quiere
      output => porcentaje del ancho 
  */
  double wp(double porcent) {
    return (width * porcent) / 100;
  }

  /*  Function(double) => double:
      input => porcentaje: Porcentaje del altura que se quiere
      output => porcentaje de la altura 
  */
  double hp(double porcent) {
    return (height * porcent) / 100;
  }

  /*  Function(double) => double:
      input => porcentaje: Porcentaje del diagonal que se quiere
      output => porcentaje de la diagonal 
  */
  double ip(double porcent) {
    return (inch * porcent) / 100;
  }
}
