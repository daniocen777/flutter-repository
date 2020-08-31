import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huevi_app/src/bloc/music_player/bloc.dart';

import 'package:huevi_app/src/pages/login/widgets/form_login.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static final route = 'login';

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MusicPlayerBloc _musicPlayerBloc;

  @override
  void initState() {
    super.initState();
    _musicPlayerBloc = MusicPlayerBloc();
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
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
                          builder:
                              (BuildContext context, MusicPlayerState state) {
                            return AspectRatio(
                                aspectRatio: 16 / 11,
                                child: Stack(
                                  children: <Widget>[
                                    FadeInImage(
                                      image: AssetImage(
                                          "assets/images/login/logo.jpg"),
                                      placeholder: AssetImage(
                                          "assets/images/login/loading.gif"),
                                      fadeInDuration:
                                          Duration(milliseconds: 750),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                        right: 5.0,
                                        top: 5.0,
                                        child: (state.status ==
                                                MusicPlayerStatus.play)
                                            ? CupertinoButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text('Apágame esa huevada',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'sans')),
                                                    SizedBox(width: 5.0),
                                                    Icon(Icons.pause,
                                                        size: 20.0,
                                                        color: Colors.black),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  _musicPlayerBloc
                                                      .add(PauseTrackEvent());
                                                })
                                            : CupertinoButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text('Ponme la música',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'sans')),
                                                    SizedBox(width: 5.0),
                                                    Icon(Icons.play_arrow,
                                                        size: 20.0,
                                                        color: Colors.black),
                                                  ],
                                                ),
                                                onPressed: () {
                                                  _musicPlayerBloc
                                                      .add(PlayTrackEvent());
                                                })),
                                  ],
                                ));
                          },
                        ),
                        Text("No te huevees y pon bien tus datos",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontFamily: "Signatra")),
                        LoginForm()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
