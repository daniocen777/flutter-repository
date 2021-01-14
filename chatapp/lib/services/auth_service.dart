import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatapp/global/environments.dart';
import 'package:chatapp/models/response.dart';
import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/utils/alertas.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage(); // Create storage
  final Map<String, String> _headers = {'Content-Type': 'application/json'};

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  // Getter token
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken(BuildContext context) async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
    final socketervice = Provider.of<SocketService>(context, listen: false);
    socketervice.disconnect();
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    this.autenticando = true;
    final data = {"email": email, "password": password};
    final response = await http.post('${Environment.apiUrl}/login',
        body: jsonEncode(data), headers: this._headers);

    this.autenticando = false;
    if (response.statusCode == 200) {
      final Response loginResponse = responseFromJson(response.body);
      if (loginResponse.ok) {
        this.usuario =
            usuarioFromJson(jsonEncode(loginResponse.obj['usuario']));
        // Guardar token
        await this._saveToken(jsonEncode(loginResponse.obj['token']));
        // Conectar con el socket
        final socketervice = Provider.of<SocketService>(context, listen: false);
        socketervice.connect();
        Navigator.pushReplacementNamed(context, UsuariosPage.route);
      } else {
        mostrarAlerta(context, title: 'Error', subtitle: loginResponse.msj);
      }
    } else {
      mostrarAlerta(context, title: 'Error', subtitle: 'Error en el servidor');
    }
  }

  Future<void> register(BuildContext context, String nombre, String email,
      String password) async {
    this.autenticando = true;
    final data = {"nombre": nombre, "email": email, "password": password};
    final response = await http.post('${Environment.apiUrl}/login/new',
        body: jsonEncode(data), headers: this._headers);

    this.autenticando = false;
    if (response.statusCode == 200) {
      final Response registerResponse = responseFromJson(response.body);
      if (registerResponse.ok) {
        this.usuario =
            usuarioFromJson(jsonEncode(registerResponse.obj['usuario']));
        // Guardar token
        await this._saveToken(jsonEncode(registerResponse.obj['token']));
        // Conectar con el socket
        final socketervice = Provider.of<SocketService>(context, listen: false);
        socketervice.connect();
        Navigator.pushReplacementNamed(context, UsuariosPage.route);
      } else {
        mostrarAlerta(context, title: 'Error', subtitle: registerResponse.msj);
      }
    } else {
      mostrarAlerta(context, title: 'Error', subtitle: 'Error en el servidor');
    }
  }

  // Verificar token
  Future<bool> isLogin(BuildContext context) async {
    final token = await this._storage.read(key: 'token');
    if (token == null) return false;
    final response = await http.get('${Environment.apiUrl}/login/renew',
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.replaceAll('"', '')
        });

    if (response.statusCode == 200) {
      final Response registerResponse = responseFromJson(response.body);
      if (registerResponse.ok) {
        print('ES OK');
        this.usuario =
            usuarioFromJson(jsonEncode(registerResponse.obj['usuario']));
        // Guardar token
        await this._saveToken(jsonEncode(registerResponse.obj['token']));
        return true;
      } else {
        this.logout(token);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    // Write value
    await _storage.write(key: 'token', value: token);
  }

  Future<void> logout(String token) async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
