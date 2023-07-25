import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either/either.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_response_body.dart';

enum HttpMethod { get, post, patch, put, delete }

class Http {
  Http(
      {required Client client, required String baseUrl, required String apiKey})
      : _client = client,
        _baseUrl = baseUrl,
        _apiKey = apiKey;

  final String _baseUrl;
  final String _apiKey;
  final Client _client;

  Future<Either<HttpFailure, T>> request<T>(String path,
      {required T Function(dynamic responseBody) onSuccess,
      HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      Map<String, dynamic> body = const {},
      bool useApiKey = true}) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;

    try {
      if (useApiKey) {
        queryParameters = {...queryParameters, 'api_key': _apiKey};
      }
      // url para cualquir api
      Uri url = Uri.parse(path.startsWith('http') ? path : '$_baseUrl$path');
      if (queryParameters.isNotEmpty) {
        url = url.replace(
            queryParameters:
                queryParameters); // copia de url agregando parámetros
      }
      headers = {'Content-Type': 'application/json', ...headers};
      late final Response response;
      final bodyString = jsonEncode(body);
      logs = {'url': url.toString(), 'method': method.name, 'body': body};
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response =
              await _client.post(url, headers: headers, body: bodyString);
          break;
        case HttpMethod.patch:
          response =
              await _client.patch(url, headers: headers, body: bodyString);
          break;
        case HttpMethod.put:
          response = await _client.put(url, headers: headers, body: bodyString);
          break;
        case HttpMethod.delete:
          response =
              await _client.delete(url, headers: headers, body: bodyString);
          break;
      }

      final statusCode = response.statusCode;
      final responseBody = _parseResponseBody(response.body);
      logs = {
        ...logs,
        'startTime': DateTime.now().toString(),
        'statusCode': statusCode,
        'responseBody': responseBody
      };
      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(onSuccess(responseBody));
      }
      return Either.left(
          HttpFailure(statusCode: statusCode, data: responseBody));
    } catch (e, s) {
      stackTrace = s;
      // stackTrace => linea donde se ubica el error
      logs = {...logs, 'exception': e.runtimeType};
      // Error de conexión en web y movil
      if (e is SocketException || e is ClientException) {
        return Either.left(HttpFailure(exception: NetworkException()));
      }

      return Either.left(HttpFailure(exception: e));
    } finally {
      logs = {...logs, 'endTime': DateTime.now().toString()};
      _printLogs(logs, stackTrace);
    }
  }
}
