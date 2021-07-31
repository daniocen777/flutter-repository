import 'package:currencyapp/src/provider/response/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart'; // Retornar dos variables en una función

/* https://fixer.io/ */

/* 26:30 */

/* http://data.fixer.io/api/symbols?access_key=c30ddcf5a63d37e8c15d7754aef787b4 */

class RestProvider {
  static const String _accessKey = "c30ddcf5a63d37e8c15d7754aef787b4";
  static const String _urlBase = "data.fixer.io";
  static const String _symbols = "api/symbols"; // Símbolos
  // Moneda base y sus valores
  static const String _latest = "api/2013-12-24";
  final http.Client _httpClient;
  Map<String, String> _header = {'Content-Type': 'application/json'};

  RestProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<Tuple2<Map<String, dynamic>, int>> latest() async {
    final ApiResponse resutl = await this._callGetApi(
        endPoint: _latest, params: {'access_key': _accessKey, 'base': 'EUR'});
    return Tuple2(resutl.rates!, resutl.timestamp!);
  }

  Future<Map<String, dynamic>> symbols() async {
    final ApiResponse result = await this
        ._callGetApi(endPoint: _symbols, params: {'access_key': _accessKey});
    return result.symbols!;
  }

  Future<ApiResponse> _callGetApi(
      {required String endPoint, Map<String, String>? params}) async {
    final uri = Uri.http(_urlBase, endPoint, params);

    try {
      final response = await _httpClient.get(uri, headers: this._header);
      final ApiResponse result = apiResponseFromJson(response.body);
      if (!result.success!) {
        switch (result.error!.code) {
          case 101:
            throw InvalidKeyException();
          case 104:
            throw RequestReachedException();
          case 201:
            throw InvalidBaseCurrencydException();
          default:
            throw new Exception('ERROR');
        }
      }

      return result;
    } catch (e) {
      print('$e');
      return ApiResponse();
    }
  }
}

class InvalidKeyException implements Exception {
  final String message =
      'No API Key was specified or an invalid API Key was specified.';
}

class RequestReachedException implements Exception {
  final String message =
      'The maximum allowed API amount of monthly API requests has been reached.';
}

class InvalidBaseCurrencydException implements Exception {
  final String message = 'An invalid base currency has been entered.';
}
