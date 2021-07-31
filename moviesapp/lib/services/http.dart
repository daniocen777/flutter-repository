import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviesapp/models/config.dart';

class HttpService {
  final Dio dio = new Dio();
  final getIt = GetIt.instance;

  late String _baseUrl;
  late String _apiKey;

  HttpService() {
    AppConfig _config = getIt.get<AppConfig>();
    _baseUrl = _config.baseApiUrl!;
    _apiKey = _config.apiKey!;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_baseUrl$path';
      Map<String, dynamic> _query = {'api_key': '', 'language': 'es-PE'};
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
      print('ERROR ==> service/http.dart | get');
      return null;
    }
  }
}
