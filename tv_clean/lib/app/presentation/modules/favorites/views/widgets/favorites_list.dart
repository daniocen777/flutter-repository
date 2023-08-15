import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/media/media.dart';
import '../../../../global/utils/get_image_url.dart';
import '../../../../utils/go_to_media_detail.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key, required this.items});

  final List<Media> items;

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

// AutomaticKeepAliveClientMixin => Preservar el estado
class _FavoritesListState extends State<FavoritesList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // Preservar el estado
    super.build(context);
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (_, int index) {
        final item = widget.items[index];
        return MaterialButton(
          onPressed: () => goToMediaDetail(item, context),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: getImageUrl(item.posterPath),
                width: 60.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5.0),
                    Text(
                      item.overview,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12.0),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
