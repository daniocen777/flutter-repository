import 'package:bloc/bloc.dart';
import 'package:cupertinoapp/src/blocs/master/master_event.dart';
import 'package:cupertinoapp/src/blocs/master/master_state.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  @override
  get initialState => MasterState.initialState();

  @override
  Stream<MasterState> mapEventToState(MasterEvent event) async* {
    if (event is MasterSetTab) {
      yield this.state.copyWith(currentTab: event.tab);
    } else if (event is MasterAddToHistory) {
      yield* _addToHistory(event);
    } else if (event is MasterRemoveFromHistory) {
      yield* _removeFromHistory(event);
    } else if (event is MasterLogOut) {
      yield this.state.copyWith(history: [], currentTab: 0);
    } else if (event is MasterAddToFavorites) {
      yield* _addToFavorites(event);
    }
  }

  Stream<MasterState> _addToHistory(MasterAddToHistory event) async* {
    /* Comprobando que el video no exista en el historial */
    final int index = this
        .state
        .history
        .indexWhere((item) => item.videoId == event.youTubeVideo.videoId);
    if (index == -1) {
      /* Copia */
      final history = List<YouTubeVideo>.from(this.state.history);
      /* Agregar el nuevo video */
      history.add(event.youTubeVideo);
      /* nuevo estado */
      yield this.state.copyWith(history: history);
    }
  }

  Stream<MasterState> _addToFavorites(MasterAddToFavorites event) async* {
    /* Comprobando que el video no exista en el historial */
    final int index = this
        .state
        .favorites
        .indexWhere((item) => item.videoId == event.youTubeVideo.videoId);
    if (index == -1) {
      /* Copia */
      final favorites = List<YouTubeVideo>.from(this.state.favorites);
      /* Agregar el nuevo video */
      favorites.add(event.youTubeVideo);
      /* nuevo estado */
      yield this.state.copyWith(favorites: favorites);
    }
  }

  Stream<MasterState> _removeFromHistory(MasterRemoveFromHistory event) async* {
    final history = List<YouTubeVideo>.from(this.state.history);
    history.removeAt(event.index);
    yield this.state.copyWith(history: history);
  }
}
