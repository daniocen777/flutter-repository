import 'package:flutter/material.dart';

import '../../../domain/entities/message.dart';

class HerMessageBubble extends StatelessWidget {
  const HerMessageBubble({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 5.0),
        _ImageBubble(
          imageUrl: message.imageUrl!,
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  const _ImageBubble({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.network(
        imageUrl,
        width: size.width * 0.7,
        height: 150.0,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size.width * 0.7,
            height: 150.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: const Text('Enviando mensaje'),
          );
        },
      ),
    );
  }
}
