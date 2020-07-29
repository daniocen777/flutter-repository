import 'package:flutter/material.dart';

import 'package:cupertinoapp/src/models/youtube_model.dart';
import 'package:cupertinoapp/src/widgets/youtube-video-item.dart';

class NewVideos extends StatelessWidget {
  final List<YouTubeVideo> items;

  const NewVideos({Key key, @required this.items})
      : assert(items != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (int index) {
          final YouTubeVideo item = items[index];
          return YouTubeVideoItem(
            item: item,
          );
        }));
  }
}
