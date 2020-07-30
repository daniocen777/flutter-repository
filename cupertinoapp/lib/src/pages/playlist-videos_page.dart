import 'package:cupertinoapp/src/api/youtube_api.dart';
import 'package:cupertinoapp/src/models/youtube_model.dart';
import 'package:cupertinoapp/src/widgets/appbar_widget.dart';
import 'package:cupertinoapp/src/widgets/video-item-shimmer_widget.dart';
import 'package:cupertinoapp/src/widgets/youtube-video-item.dart';
import 'package:flutter/material.dart';

class PlayListVideoPage extends StatefulWidget {
  final String playListId;
  PlayListVideoPage({Key key, @required this.playListId}) : super(key: key);

  @override
  _PlayListVideoPageState createState() => _PlayListVideoPageState();
}

class _PlayListVideoPageState extends State<PlayListVideoPage> {
  YouTubeApi _youTubeApi =
      YouTubeApi(apiKey: 'AIzaSyCS1J_D4c0onYQu2WIXVoO-4I_QanYLJs4');
  List<YouTubeVideo> _videos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final List<YouTubeVideo> videos =
        await _youTubeApi.getPlayListVideos(widget.playListId);
    setState(() {
      _loading = false;
      _videos.addAll(videos);
    });
  }

  Widget _shimmer() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return VideoItemShimmer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              MyAppBar(
                leftIcon: 'assets/icons/back.svg',
                rightIcon: 'assets/icons/comment.svg',
                onLeftClick: () => Navigator.pop(context),
                onRightClick: () {},
              ),
              Expanded(
                child: _loading
                    ? _shimmer()
                    : ListView.builder(
                        itemCount: _videos.length,
                        itemBuilder: (BuildContext context, int index) {
                          final YouTubeVideo item = _videos[index];
                          return YouTubeVideoItem(item: item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
