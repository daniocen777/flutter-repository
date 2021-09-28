import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebookui/config/palette.dart';
import 'package:facebookui/widgtes/post_button.dart';
import 'package:facebookui/widgtes/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _PostHeader(post: this.post),
                    const SizedBox(height: 4.0),
                    Text(post.caption),
                    post.imageUrl != null
                        ? const SizedBox.shrink()
                        : const SizedBox(height: 6.0)
                  ])),
          post.imageUrl != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CachedNetworkImage(imageUrl: post.imageUrl!),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(post: post),
          )
        ]));
  }
}

class _PostStats extends StatelessWidget {
  final Post post;
  const _PostStats({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                color: Palette.facebookBlue, shape: BoxShape.circle),
            child: Icon(
              Icons.thumb_up,
              size: 10.0,
              color: Colors.white,
            )),
        const SizedBox(width: 4.0),
        Expanded(
            child: Text('${post.likes}',
                style: TextStyle(color: Colors.grey[600]))),
        Text('${post.comments} Comments',
            style: TextStyle(color: Colors.grey[600])),
        const SizedBox(width: 8.0),
        Text('${post.shares} Shares', style: TextStyle(color: Colors.grey[600]))
      ]),
      const Divider(),
      Row(children: [
        PostButton(
            icon: Icon(CupertinoIcons.hand_thumbsup,
                color: Colors.grey[600], size: 20.0),
            label: 'Like',
            onTap: () => print('Like')),
        PostButton(
            icon: Icon(CupertinoIcons.bubble_left,
                color: Colors.grey[600], size: 20.0),
            label: 'Like',
            onTap: () => print('Like')),
        PostButton(
            icon: Icon(CupertinoIcons.share,
                color: Colors.grey[600], size: 20.0),
            label: 'Like',
            onTap: () => print('Like'))
      ])
    ]);
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ProfileAvatar(imageUrl: post.user.imageUrl),
      const SizedBox(width: 8.0),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(post.user.name,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        Row(children: [
          Text('${post.timeAgo} ° ',
              style: TextStyle(color: Colors.grey[600], fontSize: 12.0)),
          Icon(Icons.public, color: Colors.grey[600], size: 12.0)
        ])
      ])),
      IconButton(
          onPressed: () => print('Ver post'), icon: Icon(Icons.more_horiz))
    ]);
  }
}
