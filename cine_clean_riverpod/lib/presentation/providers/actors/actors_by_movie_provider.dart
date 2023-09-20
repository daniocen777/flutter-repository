import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import 'actors_repository_provider.dart';

/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

/* Providers */
final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final acotrRepository = ref.watch(actorRepositoryProvider);
  return ActorByMovieNotifier(getActors: acotrRepository.getActorsByMovie);
});

/* Tipos y clases para el provider */
typedef GetActorsCallback = Future<List<Actor>> Function(String movieID);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  ActorByMovieNotifier({required this.getActors}) : super({});

  final GetActorsCallback getActors;

  Future<void> loadActors(String movieId) async {
    if (state['movieId'] != null) return; // si ya está cargado
    final List<Actor> actors = await getActors(movieId);
    // Nuevo estado
    state = {...state, movieId: actors}; // movie en memoria
  }
}
