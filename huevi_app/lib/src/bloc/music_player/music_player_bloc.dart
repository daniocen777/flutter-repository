import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huevi_app/src/libs/assets_audio_player.dart';
import 'music_player_state.dart';
import 'music_player_event.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final MusicPlayer _musicPlayer = MusicPlayer();

  MusicPlayerBloc() : super(MusicPlayerState.initialState) {
    this._play();
  }

  @override
  Future<void> close() {
    _musicPlayer.dispose();
    return super.close();
  }

  static MusicPlayerBloc of(BuildContext context) {
    return BlocProvider.of<MusicPlayerBloc>(context);
  }

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async* {
    if (event is PlayTrackEvent) {
      yield this.state.copyWith(status: MusicPlayerStatus.play);
      this._play();
    }
    if (event is PauseTrackEvent) {
      yield this.state.copyWith(status: MusicPlayerStatus.pause);
      this._pause();
    }
  }

  _pause() {
    _musicPlayer.pause();
  }

  _play() {
    _musicPlayer.playAsset('assets/songs/huevadas.mp3');
  }
}
