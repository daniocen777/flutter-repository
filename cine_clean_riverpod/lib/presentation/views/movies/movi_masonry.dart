import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../domain/entities/movie.dart';
import '../views.dart';

class MovieMasondy extends StatefulWidget {
  const MovieMasondy({super.key, required this.movies, this.loadNextPage});

  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  @override
  State<MovieMasondy> createState() => _MovieMasondyState();
}

class _MovieMasondyState extends State<MovieMasondy> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if (scrollController.position.pixels + 100 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        itemCount: widget.movies.length,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        itemBuilder: (BuildContext context, int index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40.0),
                MoviePosterLink(movie: widget.movies[index]),
              ],
            );
          }
          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
