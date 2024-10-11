import 'package:dio/dio.dart';

import '../../core/error/exception.dart';
import '../model/character_response.dart.dart';

abstract class CharacterDatasource {
  Future<CharacterResponse?> getCharacters(
      {required int limit, required int offset});
}

class CharacterDatasourceImpl implements CharacterDatasource {
  CharacterDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<CharacterResponse?> getCharacters(
      {required int limit, required int offset}) async {
    final params = {
      'limit': limit,
      'offset': offset,
    };
    try {
      final dioResponse =
          await _dio.get('/characters', queryParameters: params);

      if ((dioResponse.statusCode != 200) && (dioResponse.statusCode != 201)) {
        throw ServerException(
            message: dioResponse.data, statusCode: dioResponse.statusCode!);
      }

      return CharacterResponse.fromJson(dioResponse.data);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 503);
    }
  }
}
