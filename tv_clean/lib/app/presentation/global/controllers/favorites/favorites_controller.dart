import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../state_notifier.dart';
import 'state/favorites_state.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController(super.state, {required this.accountRepository});

  final AccountRepository accountRepository;

  Future<void> init() async {
    final moviesResult = await accountRepository.getFavorites(MediaType.movie);
    state = await moviesResult.when(
      left: (_) async => state = FavoritesState.failed(),
      right: (moviesMap) async {
        final seriesResult = await accountRepository.getFavorites(MediaType.tv);
        return seriesResult.when(
          left: (_) => state = FavoritesState.failed(),
          right: (seriesMap) => FavoritesState.loaded(
            movies: moviesMap,
            series: seriesMap,
          ),
        );
      },
    );
  }
}
