import 'package:Whatsappclone/global/environment.dart';
import 'package:Whatsappclone/models/mensaje_response.dart';
import 'package:Whatsappclone/models/usuario.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ChatService {
  Usuario usuarioPara; // a quién va los mensajes
  final _storage = new FlutterSecureStorage();
  List<Mensaje> mensajes;

  Usuario mensajePara(Usuario usuario) {
    this.usuarioPara = usuario;
    return usuario;
  }

  Future<List<Mensaje>> getChat(String usuarioId) async {
    final token = await this._storage.read(key: 'token');
    Map<String, String> headerConToken = {
      'Content-Type': 'application/json',
      'x-token': token
    };
    try {
      final respuesta = await http.get(
          '${Environments.apiUrl}/mensajes/$usuarioId',
          headers: headerConToken);
      final MensajeResponse mensajeResponse =
          mensajeResponseFromJson(respuesta.body);
      this.mensajes = mensajeResponse.obj.mensajes;

      print(
          '********************************************************************');
      mensajes.forEach((msg) => print(msg.mensaje));
      return mensajes;
    } catch (e) {
      print('ERROR => $e');
      return [];
    }
  }
}
