import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either/either.dart';
import '../../../../../domain/failures/http_request/http_request_failure.dart';
import '../../../../../domain/models/performer/performer.dart';
import '../../../../../domain/repositories/movie_repository.dart';
import '../../../../global/utils/get_image_url.dart';
import '../../../../global/widgets/request_failed.dart';

class MovieCast extends StatefulWidget {
  const MovieCast({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  late Future<Either<HttpRequestFailure, List<Performer>>> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  void _initFuture() {
    _future = context.read<MovieRepository>().getCastByMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpRequestFailure, List<Performer>>>(
      key: ValueKey(_future), // si no tenemos el cast, volver a solicitar
      future: _future,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return snapshot.data!.when(
          left: (_) => RequestFailed(onRetry: () {
            setState(() {
              _initFuture();
            });
          }),
          right: (cast) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Cast',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (_, int index) {
                    final performer = cast[index];
                    return Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (_, constraint) {
                              final size = constraint.maxHeight;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(size / 2),
                                child: CachedNetworkImage(
                                  imageUrl: getImageUrl(performer.profilePath),
                                  height: size,
                                  width: size,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          performer.name,
                          style: const TextStyle(fontSize: 11.0),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
