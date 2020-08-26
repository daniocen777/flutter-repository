import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/src/blocs/music_player/bloc.dart';

class MusicControls extends StatelessWidget {
  const MusicControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicPlayerBloc bloc = MusicPlayerBloc.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
            padding: EdgeInsets.all(5.0),
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(60.0),
            child: Icon(Icons.skip_previous, size: 40.0, color: Colors.black),
            onPressed: () {
              bloc.add(PrevTrackEvent());
            }),
        SizedBox(
          width: 25.0,
        ),
        CupertinoButton(
            padding: EdgeInsets.all(5.0),
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(60.0),
            child: Icon(Icons.play_arrow, size: 60.0, color: Colors.black),
            onPressed: () {}),
        SizedBox(
          width: 25.0,
        ),
        CupertinoButton(
            padding: EdgeInsets.all(5.0),
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(60.0),
            child: Icon(Icons.skip_next, size: 40.0, color: Colors.black),
            onPressed: () {
              bloc.add(NextTrackEvent());
            })
      ],
    );
  }
}
