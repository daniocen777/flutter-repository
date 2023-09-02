import '../../../domain/either/either.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/character/character.dart';
import '../../../domain/models/typedefs.dart';
import '../../http/http.dart';
import '../utils/handle_failure.dart';

class RickAndMortyApi {
  RickAndMortyApi(this._http);

  final Http _http;

  Future<Either<HttpRequestFailure, List<Character>>> getCharacters() async {
    // https://rickandmortyapi.com/api/character
    final result = await _http.request(
      '/character',
      useApiKey: false,
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        return list.map((e) => Character.fromJson(e)).toList();
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (list) => Either.right(list),
    );
  }
}
