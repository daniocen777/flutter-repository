import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../movies/movies_repository_provider.dart';

/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

/* Providers */
// para mantener el query de busqueda en el searchDelegate
final searchQueryProvider = StateProvider<String>((ref) => '');

// para mantener las peliculas antes buscadas
final searchedMoviesProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchMoviesNotifier(
      searchMoviesCallback: movieRepository.searchMovie, ref: ref);
});

/* Tipos y clases para el provider */
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchMoviesNotifier({required this.searchMoviesCallback, required this.ref})
      : super([]);

  final SearchMoviesCallback searchMoviesCallback;
  final Ref ref;

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMoviesCallback(query);
    // actualizar el valor del query
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies; // Solo mantener las ultimas peliculas buscadas
    return movies;
  }
}
