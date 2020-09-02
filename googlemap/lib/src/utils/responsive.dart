import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive {
  double _width;
  double _height;
  double _diagonal;
  bool _isTabled;

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    this._width = size.width;
    this._height = size.height;
    this._diagonal = math.sqrt((math.pow(_width, 2) + math.pow(_height, 2)));
    // Retorna el mínimo valor del tamaño de la pantalla
    this._isTabled = size.shortestSide >= 600;
  }

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;
  bool get isTabled => _isTabled;

  static Responsive of(BuildContext context) => Responsive(context);

  /* Porcentaje del ancho */
  double wp(double porcent) => _width * porcent / 100.0;

  /* Porcentaje de la altura */
  double hp(double porcent) => _height * porcent / 100.0;

  /* Porcentaje de la diagonal */
  double dp(double porcent) => _diagonal * porcent / 100.0;
}
