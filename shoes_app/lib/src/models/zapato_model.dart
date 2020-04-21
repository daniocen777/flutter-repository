import 'package:flutter/material.dart';

class ZapatoModel with ChangeNotifier {
  String _assetimage = 'assets/imgs/azul.png';
  double _talla = 9.0;

  String get assetimage => this._assetimage;
  double get talla => this._talla;

  set assetimage(String valor) {
    this._assetimage = valor;
    notifyListeners();
  }

  set talla(double valor) {
    this._talla = valor;
    notifyListeners();
  }
}
