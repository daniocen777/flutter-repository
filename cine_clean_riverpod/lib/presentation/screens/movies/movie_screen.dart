import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/actor.dart';
import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key, required this.movieId});

  static const name = 'movie-screen';

  final String movieId;

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    // Info de pelicula
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    // Actores
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            movie: movie,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (_, __) => _MovieDetail(
                      movie: movie,
                    ),
                childCount: 1),
          ),
        ],
      ),
    );
  }
}

class _MovieDetail extends StatelessWidget {
  const _MovieDetail({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Imagen */
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10.0),
              /* Descripcion */
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                    ),
                    Text(
                      movie.overview,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        /* Generos */
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ))
            ],
          ),
        ),
        /* Actores */
        _ActorByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 50.0)
      ],
    );
  }
}

// Provider que solo estara en este archivo (no en otro screen)
/* FutureProvider => asincrono 
  => .family => para mandar argumentos en el provider
*/
final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMovieFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  const _CustomSliverAppBar({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoritesMoviesProvider.notifier)
                .toggleFavorite(movie);
            // Volver hacer la peticion (para confirmar y que cambie el icono al hacer el toggle)
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture.when(
            data: (isFavorite) => isFavorite
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                  ),
            error: (_, __) => throw UnimplementedError(),
            loading: () => const CircularProgressIndicator(),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        /* title: Text(
          movie.title,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 20.0),
        ), */
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            // Gradiente para la parte de favoritos
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [
                  0.0,
                  0.2
                ],
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ]),

            // Gradiente para la parte de abajo
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.8,
                  1.0
                ],
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ]),

            // Gradiente para la parte del boton de regreso
            const _CustomGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.3
                ],
                colors: [
                  Colors.black87,
                  Colors.transparent,
                ]),
          ],
        ),
      ),
    );
  }
}

class _ActorByMovie extends ConsumerWidget {
  const _ActorByMovie({required this.movieId});

  final String movieId;

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2.0),
      );
    }

    final List<Actor> actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (_, int index) {
          final actor = actors[index];
          return Container(
            width: 135.0,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // foto
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      actor.profilePath,
                      width: 135.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // nombre
                const SizedBox(height: 5.0),
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: begin,
          end: end,
          stops: stops,
          colors: colors,
        )),
      ),
    );
  }
}
