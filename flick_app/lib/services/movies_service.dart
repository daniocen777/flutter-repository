import 'package:flick_app/services/http_service.dart';
import 'package:get_it/get_it.dart';

class MoviesService {
  final getIt = GetIt.instance;
  late HttpService _http;

  MoviesService() {
    _http = getIt.get<HttpService>();
  }
}
