import 'package:cupertinoapp/src/pages/home-widgets.dart/home-tab-shimmer.dart';
import 'package:cupertinoapp/src/pages/home-widgets.dart/new-videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertinoapp/src/api/youtube_api.dart';
import 'package:cupertinoapp/src/models/playlist_model.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';
import 'package:cupertinoapp/src/pages/home-widgets.dart/top-playlist.dart';

import 'package:cupertinoapp/src/api/account_api.dart';
import 'package:flutter/rendering.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  AccountApi _accountApi = AccountApi();
  List<dynamic> _users = [];
  List<PlayList> _playLists = [];
  List<YouTubeVideo> _newVideos = [];
  bool _isLoading = true;
  /* Api */
  YouTubeApi _youTubeApi =
      YouTubeApi(apiKey: 'AIzaSyCS1J_D4c0onYQu2WIXVoO-4I_QanYLJs4');

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final users = await _accountApi.getUser(1);
    final List<PlayList> playLists =
        await _youTubeApi.getPlayList('UCwXdFgeE9KYzlDdR7TG9cMw');
    final List<YouTubeVideo> newVideos =
        await _youTubeApi.getNewVideos('UCwXdFgeE9KYzlDdR7TG9cMw');
    setState(() {
      _users.addAll(users);
      _playLists.addAll(playLists);
      _newVideos.addAll(newVideos);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        _isLoading
            ? HomeTabShimmer()
            : Column(
                children: <Widget>[
                  /* Lista de usuarios */
                  Container(
                    height: 110.0,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _users.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dynamic item = _users[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 80.0,
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    child: ClipOval(
                                        child: CachedNetworkImage(
                                  imageUrl: item['avatar'],
                                  placeholder: (_, __) {
                                    return Center(
                                      child: CupertinoActivityIndicator(
                                        radius: 15.0,
                                      ),
                                    );
                                  },
                                ))),
                                Text(item['first_name'])
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  /* Lista de reproducción */
                  TopPlayList(items: _playLists),
                  SizedBox(height: 10.0),
                  /* Nuevos videos del canal */
                  NewVideos(items: _newVideos)
                ],
              )
      ],
    );
  }
}
