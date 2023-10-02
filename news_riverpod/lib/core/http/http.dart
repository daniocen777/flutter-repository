import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

part 'failure.dart';
// part 'parse_response_body.dart';

enum HttpMethod { get, post, patch, put, delete }

class Http {
  Http({required String baseUrl, required String apiKey, required Dio client})
      : _baseUrl = baseUrl,
        _apiKey = apiKey,
        _client = client;

  final String _baseUrl;
  final String _apiKey;
  final Dio _client;

  Future<Either<HttpFailure, T>> request<T>(
    String path, {
    required T Function(dynamic responseBody) onSuccess,
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool useApiKey = true,
    Duration timeOut = const Duration(seconds: 10),
  }) async {
    // Map<String, dynamic> logs = {};
    // StackTrace? stackTrace;

    try {
      if (useApiKey) {
        queryParameters = {...queryParameters, 'apiKey': _apiKey};
      }

      // url para cualquir api
      Uri url = Uri.parse(path.startsWith('http') ? path : '$_baseUrl$path');
      // String url = path.startsWith('http') ? path : '$_baseUrl$path';
      if (queryParameters.isNotEmpty) {
        url = url.replace(
            queryParameters:
                queryParameters); // copia de url agregando parámetros
      }
      headers = {'Content-Type': 'application/json', ...headers};
      /* print(
          '************** url.toString() => ${url.toString()} **************'); */
      late final Response response;
      final bodyString = jsonEncode(body);
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url.toString()).timeout(timeOut);
          break;
        case HttpMethod.post:
          response = await _client
              .post(url.toString(),
                  data: bodyString, options: Options(headers: headers))
              .timeout(timeOut);
          break;
        case HttpMethod.patch:
          response = await _client
              .patch(url.toString(),
                  data: bodyString, options: Options(headers: headers))
              .timeout(timeOut);
          break;
        case HttpMethod.put:
          response = await _client
              .put(url.toString(),
                  data: bodyString, options: Options(headers: headers))
              .timeout(timeOut);
          break;
        case HttpMethod.delete:
          response = await _client
              .delete(url.toString(),
                  data: bodyString, options: Options(headers: headers))
              .timeout(timeOut);
          break;
      }
      final statusCode = response.statusCode ?? -1;
      // print('********* STATUS \n $statusCode \n *********');
      // print('********* RESPONSE => ${response.data} \n *********');
      //  final responseBody = _parseResponseBody(response.data);
      if (statusCode >= 200 && statusCode < 300) {
        // print('OKOKOKOKOKOKOKOKOKOKOOKOKOKOKOKOKOKOKOKOKO');
        return Right(onSuccess(response.data));
      }
      // print('ERRORERRORERRORERRORERRORERRORERRORERRORERROR 1');
      return Left(HttpFailure(statusCode: statusCode, data: response.data));
    } catch (e) {
      // print('ERRORERRORERRORERRORERRORERRORERRORERRORERROR 2');
      // stackTrace = s;
      // stackTrace => linea donde se ubica el error
      // Error de conexión en web y movil
      if (e is SocketException) {
        return Left(
            HttpFailure(exception: NetworkException(), data: e.toString()));
      }
      return Left(HttpFailure(exception: e));
    } finally {
      // print(stackTrace);
    }
  }
}
