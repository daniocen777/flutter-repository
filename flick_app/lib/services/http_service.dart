import 'package:dio/dio.dart';
import 'package:flick_app/models/app_config.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final _dio = Dio();
  final _getIt = GetIt.instance;

  late String _baseUrl;
  late String _apiKey;

  HttpService() {
    AppConfig _config = _getIt<AppConfig>();
    _baseUrl = _config.baseApiUrl;
    _apiKey = _config.baseApiUrl;
  }

  Future<Response?> get(String? path, Map<String, dynamic>? query) async {
    try {
      String _url = '$_baseUrl$path';
      Map<String, dynamic> _query = {
        'api_key': _apiKey,
        'languaje': 'es-ES',
      };

      if (query != null) {
        _query.addAll(query);
      }

      return await _dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
      print('****** ERROR ****** => ${e.message}');
      return null;
    }
  }
}
