import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/src/blocs/home/bloc.dart';
import 'package:musicapp/src/db/app_theme.dart';
import 'package:musicapp/src/models/artist_model.dart';
import 'package:musicapp/src/pages/music_player/music_player_page.dart';

class MyArtists extends StatelessWidget {
  const MyArtists({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
        return SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
          final Artist artist = state.artists[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
              onPressed: () {
                final route = MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MusicPlayerPage(artist: artist));
                Navigator.push(context, route);
              },
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                    color: MyAppTheme.instance.darkEnabled
                        ? Color(0xff37474f).withOpacity(0.2)
                        : Color(0xfff0f0f0),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: artist.picture,
                              width: 60.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(artist.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: MyAppTheme.instance.darkEnabled
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'sans')),
                                Text('${artist.tracklist.length} tracks',
                                    style: TextStyle(fontFamily: 'sans')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: Icon(Icons.play_arrow),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }, childCount: state.artists.length));
      },
    );
  }
}
