import 'package:get_it/get_it.dart';
import 'package:moviesapp/services/http.dart';

class MoviesService {
  final getIt = GetIt.instance;

  late HttpService _http;

  MoviesService() {
    this._http = getIt.get<HttpService>();
  }
}