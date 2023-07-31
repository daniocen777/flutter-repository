import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/performer/performer.dart';
import '../../../../../global/utils/get_image_url.dart';
import '../movies_and_series/trending_tile.dart';

class PerformerTile extends StatelessWidget {
  const PerformerTile({super.key, required this.performer});

  final Performer performer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            Positioned.fill(
                child: CachedNetworkImage(
              imageUrl: getImageUrl(performer.profilePath,
                  imageQuality: ImageQuality.original),
              fit: BoxFit.cover,
              placeholder: (_, __) => const SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: Center(child: CircularProgressIndicator())),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            )),
            Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.all(15.0).copyWith(bottom: 40.0),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.transparent,
                        Colors.black,
                      ])),
                  child: Column(
                    children: [
                      Text(
                        performer.name,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      if (performer.name != performer.originalName)
                        Text(
                          performer.originalName,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(height: 10.0),
                      if (performer.knownFor.isNotEmpty)
                        SizedBox(
                            height: 120,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: performer.knownFor
                                    .take(3)
                                    .map((media) => TrendingTile(
                                          media: media,
                                          width: 120.0 * 0.7,
                                          showData: false,
                                        ))
                                    .toList()))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
