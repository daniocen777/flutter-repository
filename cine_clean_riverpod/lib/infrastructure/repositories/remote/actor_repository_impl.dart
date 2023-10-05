import '../../../domain/datasources/remote/actors_datasource.dart';
import '../../../domain/entities/actor.dart';
import '../../../domain/repositories/remote/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorDatasource;

  ActorRepositoryImpl(this.actorDatasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return actorDatasource.getActorsByMovie(movieId);
  }
}
