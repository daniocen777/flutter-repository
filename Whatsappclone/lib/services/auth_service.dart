import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:Whatsappclone/models/usuario.dart';
import 'package:Whatsappclone/models/usuarios_response.dart';
import 'package:Whatsappclone/models/login_response.dart';
import 'package:Whatsappclone/global/environment.dart';

class AuthService {
  Map<String, String> header = {'Content-Type': 'application/json'};

  LoginResponse loginResponse;
  // Create storage
  final _storage = new FlutterSecureStorage();

  Future<LoginResponse> login(String email, String password) async {
    final data = {'email': email, 'password': password};

    try {
      final respuesta = await http.post('${Environments.apiUrl}/login',
          body: jsonEncode(data), headers: this.header);

      final LoginResponse loginResponse = loginResponseFromJson(respuesta.body);

      await this._guardarToken(loginResponse.obj['token']);

      return loginResponse;
    } catch (e) {
      print('ERROR => $e');
      return LoginResponse(ok: false, msj: 'Error de servidor', status: 500);
    }
  }

  Future<LoginResponse> registro(
      String nombre, String email, String password) async {
    final data = {'nombre': nombre, 'email': email, 'password': password};

    try {
      final respuesta = await http.post('${Environments.apiUrl}/login/new',
          body: jsonEncode(data), headers: this.header);

      final LoginResponse loginResponse = loginResponseFromJson(respuesta.body);
      final tokenMap = loginResponse.obj['token'];
      print('TIPO DE VALOR ${tokenMap.runtimeType}');

      await this._guardarToken(loginResponse.obj['token']);

      return loginResponse;
    } catch (e) {
      print('ERROR => $e');
      return LoginResponse(ok: false, msj: 'Error de servidor', status: 500);
    }
  }

  Future<LoginResponse> estaLogueado() async {
    final token = await this._storage.read(key: 'token');
    Map<String, String> headerConToken = {
      'Content-Type': 'application/json',
      'x-token': token
    };

    try {
      final respuesta = await http.get('${Environments.apiUrl}/login/renew',
          headers: headerConToken);

      final LoginResponse loginResponse = loginResponseFromJson(respuesta.body);

      await this._guardarToken(loginResponse.obj['token']);
      return loginResponse;
    } catch (e) {
      print('ERROR => $e');
      return LoginResponse(ok: false, msj: 'Sesión expirada', status: 500);
    }
  }

  /* Lista de usuarios */
  Future<List<Usuario>> getUsuarios() async {
    final token = await this._storage.read(key: 'token');
    Map<String, String> headerConToken = {
      'Content-Type': 'application/json',
      'x-token': token
    };

    try {
      final respuesta = await http.get('${Environments.apiUrl}/usuarios',
          headers: headerConToken);

      final UsuariosResponse usuariosResponse =
          usuariosResponseFromJson(respuesta.body);
      final usuarios = usuariosResponse.obj;

      return usuarios;
    } catch (e) {
      print('ERROR => $e');
      return [];
    }
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    return await _storage.read(key: 'token');
  }

  static Future<void> eliminarToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<void> _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}
