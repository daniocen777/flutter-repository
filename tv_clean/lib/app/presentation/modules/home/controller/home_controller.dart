import '../../../../domain/enums.dart';
import '../../../../domain/repositories/trending_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/home_state.dart';

class HomeController extends StateNotifier<Homestate> {
  HomeController(super.state, {required this.trendingRepository});

  final TrendingRepository trendingRepository;

  Future<void> init() async {
    // Movies and series
    await loadMoviesAndSeries();
    // Actores
    await loadPerformers();
  }

  // Para la busqueda del dropdown
  void onTimeWindowChanged(TimeWindow timeWindow) {
    if (state.moviesAndSeries.timeWindow != timeWindow) {
      state = state.copyWith(
          moviesAndSeries: MoviesAndSeriesState.loading(timeWindow));

      loadMoviesAndSeries();
    }
  }

  Future<void> loadMoviesAndSeries(
      {MoviesAndSeriesState? moviesAndSeries}) async {
    if (moviesAndSeries != null) {
      state = state.copyWith(moviesAndSeries: moviesAndSeries);
    }

    final result = await trendingRepository
        .getMoviesAndSeries(state.moviesAndSeries.timeWindow);
    // Nuevo estado con el resultado o con error
    state = result.when(
        left: (_) => state.copyWith(
            moviesAndSeries:
                MoviesAndSeriesState.failed(state.moviesAndSeries.timeWindow)),
        right: (list) => state.copyWith(
            moviesAndSeries: MoviesAndSeriesState.loaded(
                timeWindow: state.moviesAndSeries.timeWindow, list: list)));
  }

  Future<void> loadPerformers({PerformersState? performers}) async {
    if (performers != null) {
      state = state.copyWith(performers: performers);
    }
    final resutlt = await trendingRepository.getPerformers();
    // Nuevo estado con el resultado o con error
    state = resutlt.when(
        left: (_) => state.copyWith(performers: const PerformersState.failed()),
        right: (list) =>
            state.copyWith(performers: PerformersState.loaded(list)));
  }
}
