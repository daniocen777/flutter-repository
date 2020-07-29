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
      yield this.state.coyWith(currentTab: event.tab);
    } else if (event is MasterAddToHistory) {
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
        yield this.state.coyWith(history: history);
      }
    }
  }
}
