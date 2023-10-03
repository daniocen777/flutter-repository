import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';
import '../../providers/providers.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(width: 5.0),
                Text('Cinemapedia', style: titleStyle),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    final List<Movie> searchMovies =
                        ref.read(searchedMoviesProvider);

                    final String searchQuery = ref.read(searchQueryProvider);
                    showSearch<Movie?>(
                            query: searchQuery,
                            context: context,
                            delegate: SearchMovieDelegate(
                                initialMovies: searchMovies,
                                searchMovies: ref
                                    .read(searchedMoviesProvider.notifier)
                                    .searchMoviesByQuery))
                        .then((movie) {
                      if (movie == null) return;
                      context.push('/home/0/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
          ),
        ));
  }
}
