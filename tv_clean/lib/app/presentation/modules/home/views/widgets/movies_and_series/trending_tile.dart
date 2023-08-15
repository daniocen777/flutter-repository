import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../domain/models/media/media.dart';
import '../../../../../global/utils/get_image_url.dart';
import '../../../../../utils/go_to_media_detail.dart';

class TrendingTile extends StatelessWidget {
  const TrendingTile(
      {super.key,
      required this.media,
      required this.width,
      this.showData = true});

  final Media media;
  final double width;
  final bool showData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToMediaDetail(media, context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                // ExtendedImage => para el cache
                child: CachedNetworkImage(
                  imageUrl: getImageUrl(media.posterPath),
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
              if (showData)
                Positioned(
                    right: 5.0,
                    top: 5.0,
                    child: Opacity(
                      opacity: 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Chip(
                            // Quitar padding de arriba
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            label: Text(
                              media.voteAverage.toStringAsFixed(1),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Chip(
                            // Quitar padding de arriba
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            label: Icon(
                              media.type == MediaType.movie
                                  ? Icons.movie
                                  : Icons.tv,
                              size: 15.0,
                            ),
                          )
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
