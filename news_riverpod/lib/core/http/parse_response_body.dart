/* part of 'http.dart';

dynamic _parseResponseBody(String responseBody) {
  try {
    // print('INTENTA');
    return jsonDecode(responseBody);
  } catch (e) {
    // print('ERROR => ${e.toString()}');
    return responseBody;
  }
} */
