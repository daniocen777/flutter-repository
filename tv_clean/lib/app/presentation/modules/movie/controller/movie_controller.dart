import '../../../../domain/repositories/movie_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  MovieController(super.state,
      {required this.movieId, required this.movieRepository});

  final int movieId;
  final MovieRepository movieRepository;

  Future<void> init() async {
    final result = await movieRepository.getMovieById(movieId);
    // Nuevo estado
    state = result.when(
      left: (_) => MovieState.failed(),
      right: (movie) => MovieState.loaded(movie),
    );
  }
}
