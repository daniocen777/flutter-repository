import '../../domain/datasources/actors_datasource.dart';
import '../../domain/entities/actor.dart';
import '../../domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorDatasource;

  ActorRepositoryImpl(this.actorDatasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    return actorDatasource.getActorsByMovie(movieId);
  }
}
