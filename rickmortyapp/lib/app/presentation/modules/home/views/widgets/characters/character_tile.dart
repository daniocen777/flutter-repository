import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/character/character.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(
          imageUrl: character.image,
          width: 60.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(character.name),
            Text('Status: ${character.status}'),
          ],
        ))
      ],
    );
  }
}
