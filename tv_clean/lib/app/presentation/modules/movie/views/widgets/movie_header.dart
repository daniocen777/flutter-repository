import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/movie/movie.dart';
import '../../../../global/utils/get_image_url.dart';

class MovieHeader extends StatelessWidget {
  const MovieHeader({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
            aspectRatio: 16 / 13,
            child: movie.backdropPath != null
                ? CachedNetworkImage(
                    imageUrl: getImageUrl(movie.backdropPath!,
                        imageQuality: ImageQuality.original),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.black54,
                  )),
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black,
                  ])),
              padding: const EdgeInsets.all(15.0).copyWith(top: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        // Para los errores de oveeflow
                        Wrap(
                          spacing: 10.0,
                          children: movie.genres
                              .map(
                                (e) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      border: Border.all(color: Colors.white)),
                                  child: Text(e.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 70.0,
                        height: 70.0,
                        child: CircularProgressIndicator(
                          value: (movie.voteAverage / 10).clamp(0.0, 1.0),
                        ),
                      ),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
