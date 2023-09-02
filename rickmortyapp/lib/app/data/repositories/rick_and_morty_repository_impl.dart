import '../../domain/either/either.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../../domain/models/character/character.dart';
import '../../domain/repositories/rick_and_morty_repository.dart';
import '../datasources/remote/rick_and_morty_api.dart';

class RickAndMortyRepositoryImpl implements RickAndMortyRepository {
  RickAndMortyRepositoryImpl(this._api);
  final RickAndMortyApi _api;

  @override
  Future<Either<HttpRequestFailure, List<Character>>> getCharacters() {
    return _api.getCharacters();
  }
}
