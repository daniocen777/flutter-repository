import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_clean_architecture/core/widgets/loading_widget.dart';
import 'package:movies_clean_architecture/features/movies/presentation/blocs/movies/movies_bloc.dart';
import 'package:movies_clean_architecture/features/movies/presentation/widgets/movies_page/movies_list_widget.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}

AppBar _buildAppBar() => AppBar(
      title: const Text("Posts"),
    );

Widget _buildBody() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: BlocBuilder<MoviesBloc, MoviesState>(
      builder: (BuildContext context, state) {
        if (state is LoadingMoviesState) {
          return const LoadingWidget();
        } else if (state is LoadedMoviesState) {
          return MoviesListWidget(movies: state.movies);
        }

        return const LoadingWidget();
      },
    ),
  );
}
