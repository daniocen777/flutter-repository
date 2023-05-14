import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChracterDetailWidget extends StatelessWidget {
  final String? imageUrl;
  const ChracterDetailWidget({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) => Container(
        width: 400.0,
        height: 350,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.fitWidth),
        ),
      ),
      placeholder: (context, url) => Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const CircularProgressIndicator(),
    );
  }
}
