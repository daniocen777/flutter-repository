import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class _MenuProvider {
  // Lista dinámica
  List<dynamic> opciones = [];

  // Constructor
  _MenuProvider() {
    // Método para cargar data
    cargarData();
  }

  Future<List<dynamic>> cargarData() async {
    // Regresa un Future => No será necesario colocarlo en el constructor
    final resp = await rootBundle.loadString('data/menu_opts.json');
    // Creando un mapa
    Map dataMap = json.decode(resp);
    opciones = dataMap['cards']; // Colocando la data a opciones

    return opciones;
  }
}

// Crear una instacia de la clase
final menuProvider = new _MenuProvider();
