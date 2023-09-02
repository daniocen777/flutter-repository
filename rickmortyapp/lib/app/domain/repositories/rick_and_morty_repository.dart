import '../either/either.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/character/character.dart';

abstract class RickAndMortyRepository {
  Future<Either<HttpRequestFailure, List<Character>>> getCharacters();
}
