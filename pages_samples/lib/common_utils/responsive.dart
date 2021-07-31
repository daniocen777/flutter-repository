import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width;
  final double height;
  final double inch; // Diagonal

  Responsive({required this.width, required this.height, required this.inch});

  factory Responsive.fromSize(Size size) {
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }

  /*  Function(double) => double:
      input => porcentaje: Porcentaje del ancho que se quiere
      output => porcentaje del ancho 
  */
  double wp(double porcent) {
    return (this.width * porcent) / 100;
  }

  /*  Function(double) => double:
      input => porcentaje: Porcentaje del altura que se quiere
      output => porcentaje de la altura 
  */
  double hp(double porcent) {
    return (this.height * porcent) / 100;
  }

  /*  Function(double) => double:
      input => porcentaje: Porcentaje del diagonal que se quiere
      output => porcentaje de la diagonal 
  */
  double ip(double porcent) {
    return (this.inch * porcent) / 100;
  }
}
