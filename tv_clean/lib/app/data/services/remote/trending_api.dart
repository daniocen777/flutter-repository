import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/performer/performer.dart';
import '../../../domain/models/typedefs.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class TrendingAPI {
  final Http _http;

  TrendingAPI(this._http);

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
      TimeWindow timeWindow) async {
    final result = await _http.request(
      '/trending/all/${timeWindow.name}',
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        // Ignorar los datos media_type que sean 'person'
        // Filtrando
        return getMediaList(list);
      },
    );

    return result.when(
        left: handleHttpFailure, right: (list) => Either.right(list));
  }

  Future<Either<HttpRequestFailure, List<Performer>>> getPerformers(
      TimeWindow timeWindow) async {
    final result = await _http.request(
      '/trending/person/${timeWindow.name}',
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        // Ignorar los datos media_type que sean 'person'
        // Filtrando
        return list
            .where((e) =>
                e['known_for_department'] == 'Acting' &&
                e['profile_path'] != null)
            .map((e) => Performer.fromJson(e))
            .toList();
      },
    );

    return result.when(
        left: handleHttpFailure, right: (list) => Either.right(list));
  }
}
