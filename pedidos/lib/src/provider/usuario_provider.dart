import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pedidos/src/constants/app_constante.dart' as servicio;
import 'package:pedidos/src/models/usuario_model.dart';

class ProductoProvider {
  Future<List<Usuario>> getUsuarios() async {
    print("ANTES DE");
    final url = Uri.http(servicio.URL, "usuarios");
    print(url);
    var respuestaBackend = await http.post(url);
    final decodeData = json.decode(respuestaBackend.body);
    print(decodeData);
    return [];
  }
}
