import '../either/either.dart';
import '../failures/http_request/http_request_failure.dart';
import '../models/character/character.dart';
import '../repositories/rick_and_morty_repository.dart';

class GetChractersUseCase {
  GetChractersUseCase(this.repository);

  final RickAndMortyRepository repository;

  Future<Either<HttpRequestFailure, List<Character>>> call() async {
    return await repository.getCharacters();
  }
}
