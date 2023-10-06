import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/repositories/local/movies_local_repository.dart';
import '../providers.dart';

/* 
  Provider => Para valores inmutables (que no van a cambiar)
  StateProvider => Para mantener un estado (pendiente del cambio)
  StateNotifierProvider => Para estados más elaborados (customizado)
 */

// Providers
final favoritesMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(
      moviesLocalStorageRepository: localStorageRepository);
});

// Controladores
class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  StorageMoviesNotifier({required this.moviesLocalStorageRepository})
      : super({});

  int page = 0;
  final MoviesLocalRepository moviesLocalStorageRepository;

  Future<List<Movie>> loadNextPage() async {
    final movies = await moviesLocalStorageRepository.loadMovies(
        offset: page * 10, limit: 20);

    page++;
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    // Nuevo estado
    state = {...state, ...tempMoviesMap};
    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await moviesLocalStorageRepository.toggleFavorites(movie);
    final bool isMovieInFavorites = state[movie.id] != null;
    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
