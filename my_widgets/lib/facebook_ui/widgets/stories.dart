import 'package:flutter/material.dart';
import 'package:my_widgets/facebook_ui/widgets/avatar.dart';
import 'package:my_widgets/models/story.dart';

const _stories = [
  Story(
      bg: 'assets/wallpapers/1.jpeg',
      avatar: 'assets/users/1.jpg',
      username: 'Mireya Arriaga'),
  Story(
      bg: 'assets/wallpapers/2.jpeg',
      avatar: 'assets/users/2.jpg',
      username: 'Carola Herrera'),
  Story(
      bg: 'assets/wallpapers/3.jpeg',
      avatar: 'assets/users/3.jpg',
      username: 'Memo Lorenz'),
  Story(
      bg: 'assets/wallpapers/4.jpeg',
      avatar: 'assets/users/4.jpg',
      username: 'Carlos Hurtado'),
  Story(
      bg: 'assets/wallpapers/5.jpeg',
      avatar: 'assets/users/5.jpg',
      username: 'Lola De la Cruz'),
];

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: ListView.builder(
        itemCount: _stories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final story = _stories[index];
          return _StoryItem(
            story: story,
            isFirst: index == 0,
          );
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem({
    super.key,
    required this.story,
    this.isFirst = false,
  });

  final Story story;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      width: 90.0,
      margin: EdgeInsets.only(right: 15.0, left: isFirst ? 20 : 0),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 0.0,
                  bottom: 20.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            image: AssetImage(story.bg), fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                    bottom: 0.0,
                    child: Avatar(
                      size: 40.0,
                      asset: story.avatar,
                      borderWith: 3.0,
                    ))
              ],
            ),
          ),
          Text(
            story.username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
