import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/src/blocs/music_player/bloc.dart';
import 'package:musicapp/src/models/artist_model.dart';
import 'package:musicapp/src/pages/music_player/current_track_view.dart';
import 'package:musicapp/src/pages/music_player/music_controls.dart';

class MusicPlayerPage extends StatefulWidget {
  final Artist artist;

  MusicPlayerPage({Key key, @required this.artist})
      : assert(artist != null),
        super(key: key);

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  MusicPlayerBloc _musicPlayerBloc;

  @override
  void initState() {
    super.initState();
    print(' ****** INICIANDO PAGE ******');
    _musicPlayerBloc = MusicPlayerBloc(artist: widget.artist);
  }

  @override
  void dispose() {
    _musicPlayerBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _musicPlayerBloc,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
            child: Column(
              children: <Widget>[CurrentTrackView(), MusicControls()],
            ),
          ),
        ),
      ),
    );
  }
}
