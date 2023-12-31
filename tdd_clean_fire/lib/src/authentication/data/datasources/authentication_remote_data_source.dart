import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/typedef.dart';
import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  // En los datasources, siempre se devuelven los modelos
  Future<List<UserModel>> getUsers();
}

const createUserEndpoint = '/testapi/users';
const getUsersEndpoint = '/testapi/users';

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response =
          await _client.post(Uri.parse('$kBaseUrl$createUserEndpoint'),
              body: jsonEncode({
                'createdAt': createdAt,
                'name': name,
                'avatar': avatar,
              }));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, getUsersEndpoint));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((items) => UserModel.fromMap(items))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
