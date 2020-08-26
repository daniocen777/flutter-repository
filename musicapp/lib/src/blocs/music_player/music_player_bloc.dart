import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/src/libs/music_player.dart';
import 'package:musicapp/src/models/artist_model.dart';
import 'package:musicapp/src/models/track_model.dart';
import 'music_player_state.dart';
import 'music_player_event.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final Artist artist;
  final MusicPlayer _musicPlayer = MusicPlayer();

  MusicPlayerBloc({this.artist}) : super(MusicPlayerState.initialState()) {
    this._play();
  }

  /* _onNext() {
    add(NextTrackEvent());
  }

  _onPrev() {
    add(PrevTrackEvent());
  } */

  _play() {
    final int index = this.state.currentTrackIndex;
    final Track track = this.artist.tracks[index];
    _musicPlayer.play(track.preview);
  }

  @override
  Future<void> close() {
    _musicPlayer.dispose();
    return super.close();
  }

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async* {
    if (event is NextTrackEvent) {
      final index = this.state.currentTrackIndex + 1;
      if (index < artist.tracks.length) {
        yield this.state.copyWith(currentTrackIndex: index);
        this._play();
      }
    } else if (event is PrevTrackEvent) {
      final index = this.state.currentTrackIndex - 1;
      if (index >= 0) {
        yield this.state.copyWith(currentTrackIndex: index);
        this._play();
      }
    }
  }

  static MusicPlayerBloc of(BuildContext context) {
    return BlocProvider.of<MusicPlayerBloc>(context);
  }
}
