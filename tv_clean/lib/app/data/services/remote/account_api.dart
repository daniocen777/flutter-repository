import '../../../domain/either/either.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/user/user.dart';
import '../../http/http.dart';
import '../local/session_service.dart';
import '../utils/handle_failure.dart';

class AccountApi {
  AccountApi(this._http, this._sessionService);

  final Http _http;
  final SessionService _sessionService;

  Future<User?> getAccount(String sessionId) async {
    final result = await _http.request(
      '/account',
      queryParameters: {'session_id': sessionId},
      onSuccess: (json) {
        return User.fromJson(json);
      },
    );

    return result.when(left: (_) => null, right: (user) => user);
  }

  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(
      MediaType type) async {
    final accountId = await _sessionService.accountId;
    final result = await _http.request(
      '/account/$accountId/favorite/${type == MediaType.movie ? 'movies' : 'tv'}',
      queryParameters: {'session_id': await _sessionService.sessionId ?? ''},
      onSuccess: (json) {
        final list = json['results'] as List;
        // A map
        final iterable = list.map((e) {
          // evitar error de media_tyoe
          final media = Media.fromJson({...e, 'media_type': type.name});
          return MapEntry(media.id, media);
        });
        final map = <int, Media>{};
        map.addEntries(iterable);
        return map;
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (value) => Either.right(value),
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFavorite({
    required int mediaId,
    required MediaType mediaType,
    required bool favorite,
  }) async {
    final accountId = await _sessionService.accountId;
    final sessionId = await _sessionService.sessionId ?? '';
    final result = await _http.request('/account/$accountId/favorite',
        queryParameters: {'session_id': sessionId},
        method: HttpMethod.post,
        body: {
          'media_type': mediaType.name,
          'media_id': mediaId,
          'favorite': favorite
        },
        onSuccess: (_) => null);

    return result.when(
      left: handleHttpFailure,
      right: (_) => Either.right(null),
    );
  }
}
