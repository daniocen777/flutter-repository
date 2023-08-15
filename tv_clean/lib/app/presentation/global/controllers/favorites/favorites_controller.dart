import '../../../../domain/either/either.dart';
import '../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../state_notifier.dart';
import 'state/favorites_state.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  FavoritesController(super.state, {required this.accountRepository});

  final AccountRepository accountRepository;

  Future<void> init() async {
    state = FavoritesState.loading();
    final moviesResult = await accountRepository.getFavorites(MediaType.movie);
    state = await moviesResult.when(
      left: (_) async => state = FavoritesState.failed(),
      right: (moviesMap) async {
        final seriesResult = await accountRepository.getFavorites(MediaType.tv);
        return seriesResult.when(
          left: (_) => FavoritesState.failed(),
          right: (seriesMap) => FavoritesState.loaded(
            movies: moviesMap,
            series: seriesMap,
          ),
        );
      },
    );
  }

  // Guardar en favorites
  Future<Either<HttpRequestFailure, void>> markAsFavorite(Media media) async {
    // saber si está en favoritos (solo estará cuando el estado sea loaded)
    assert(state is FavoritesStateLoaded);
    final loadedState = state as FavoritesStateLoaded;
    // para actualizar listas o map, se necesita hacer una copia
    final map = media.type == MediaType.movie
        ? {...loadedState.movies}
        : {...loadedState.series};

    final favorite = !map.keys.contains(media.id);

    final result = await accountRepository.markAsFavorite(
        mediaId: media.id, mediaType: media.type, favorite: favorite);

    result.whenOrNull(
      right: (_) {
        // La copia
        if (favorite) {
          map[media.id] = media;
        } else {
          map.remove(media.id);
        }
        // actualziar estado
        state = media.type == MediaType.movie
            ? loadedState.copyWith(movies: map)
            : loadedState.copyWith(series: map);
      },
    );

    return result;
  }
}
