import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:timeago/timeago.dart' as timago;

import 'package:my_widgets/facebook_ui/widgets/avatar.dart';
import 'package:my_widgets/models/publication.dart';

class PublicationItem extends StatelessWidget {
  final Publication publication;

  const PublicationItem({super.key, required this.publication});

  String _getEmojiPath(Reaction reaction) {
    switch (reaction) {
      case Reaction.like:
        return 'assets/emojis/like.svg';
      case Reaction.love:
        return 'assets/emojis/heart.svg';
      case Reaction.laughing:
        return 'assets/emojis/laughing.svg';
      case Reaction.sad:
        return 'assets/emojis/sad.svg';
      case Reaction.shocking:
        return 'assets/emojis/shocked.svg';
      case Reaction.angry:
        return 'assets/emojis/angry.svg';
    }
  }

  String _formatCount(int value) {
    if (value <= 1000) {
      return value.toString();
    } else {
      return "${(value / 1000).toStringAsFixed(1)}k";
    }
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
    const reactons = Reaction.values;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          border:
              Border(top: BorderSide(width: 6.0, color: Color(0xffEBEBEB)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Row(
              children: [
                Avatar(size: 38.0, asset: publication.user.avatar),
                const SizedBox(width: 10.0),
                Text(publication.user.username),
                const Spacer(),
                Text(timago.format(publication.createdAt))
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: publication.imageUrl,
                fit: BoxFit.cover),
          ),
          Padding(
            padding: padding.copyWith(top: 15.0),
            child: Text(
              publication.title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0)
                .copyWith(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ...List.generate(reactons.length, (index) {
                      final reaction = reactons[index];
                      final isActive =
                          reaction == publication.currentUserReaction;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              _getEmojiPath(reaction),
                              width: 25.0,
                              height: 25.0,
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Icon(
                              Icons.circle,
                              color: isActive
                                  ? Colors.redAccent
                                  : Colors.transparent,
                              size: 5.0,
                            )
                          ],
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: FittedBox(
                      child: Row(
                        children: [
                          Text(
                              '${_formatCount(publication.commetsCount)} Comentarios'),
                          const SizedBox(width: 15.0),
                          Text(
                              '${_formatCount(publication.sharesCount)} Reacciones'),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
