import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../config/helpers/human_format.dart';
import '../../domain/entities/movie.dart';

// Para la funcion
typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  // Funcion  para buscar pelicula
  final SearchMovieCallback searchMovies;
  // peliculas buscadas anteriormente
  List<Movie> initialMovies;
  // Stream para controlar las peticiones (que se ejecuten cuando usuario haya terminado de escribir)
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;
  // Stream para el loading cuando se busca pelicula
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    // Cancela tiempo cuando usuario escribe
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    // cuando deja de escribir, hace la consulta
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      initialMovies = movies;
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
      // stream es nuevo y no muestra los datos (colocar valores iniciales)
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (BuildContext context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  // Sobreescribir otro metodo (no obligatorio) para cambiar placeholder
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // query => String de la caja de texto
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (_, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              infinite: true,
              spins: 10.0,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) => _buildResultsAndSuggestions();

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({required this.movie, required this.onMovieSelected});

  final Movie movie;
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          children: [
            // Imagen
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (_, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            // Descripcion
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        HumanFormats.number(movie.voteAverage, decimals: 1),
                        style: textStyle.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
