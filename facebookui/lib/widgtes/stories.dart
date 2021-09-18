import 'package:facebookui/widgtes/profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:facebookui/config/palette.dart';
import 'package:facebookui/models/models.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;

  const Stories({Key? key, required this.currentUser, required this.stories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.0,
        color: Colors.white,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: 1 + this.stories.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: _StoryCard(
                        isAddStore: true, currentUser: this.currentUser));
              }
              final Story story = this.stories[index - 1];
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _StoryCard(story: story));
            }));
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStore;
  final User? currentUser;
  final Story? story;

  const _StoryCard(
      {Key? key, this.isAddStore = false, this.currentUser, this.story})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
              width: 110.0,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: isAddStore
                  ? this.currentUser!.imageUrl
                  : this.story!.imageUrl)),
      Container(
          width: 110.0,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: Palette.storyGradient,
              borderRadius: BorderRadius.circular(12.0))),
      Positioned(
          top: 8.0,
          left: 8.0,
          child: this.isAddStore
              ? Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => print('Agregar post'),
                      icon: Icon(Icons.add),
                      iconSize: 30.0,
                      color: Palette.facebookBlue))
              : ProfileAvatar(
                  imageUrl: this.story!.user.imageUrl,
                  hasBorder: !this.story!.isViewed!)),
      Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
              this.isAddStore ? 'Agregar Historia' : this.story!.user.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700)))
    ]);
  }
}
