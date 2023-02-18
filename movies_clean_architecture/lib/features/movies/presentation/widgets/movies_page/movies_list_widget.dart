import 'package:flutter/material.dart';
import 'package:movies_clean_architecture/features/movies/domain/entities/movie.dart';

class MoviesListWidget extends StatelessWidget {
  final List<Movie> movies;

  const MoviesListWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: movies.length,
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(thickness: 1.0),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text(movies[index].id.toString()),
          title: Text(movies[index].title),
          subtitle: Text(movies[index].popularity.toString()),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        );
      },
    );
  }
}
