import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import 'movies_repository_provider.dart';

/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

/* Providers */
final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieProvider = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieProvider.getMovieByID);
});

/* Tipos y clases para el provider */
typedef GetMovieCallback = Future<Movie> Function(String movieID);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  MovieMapNotifier({required this.getMovie}) : super({});

  final GetMovieCallback getMovie;

  Future<void> loadMovie(String movieId) async {
    if (state['movieId'] != null) return; // si ya está cargado
    final movie = await getMovie(movieId);
    // Nuevo estado
    state = {...state, movieId: movie}; // movie en memoria
  }
}
