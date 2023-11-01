import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/article/article_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (BuildContext context, state) {
          if (state is LoadingArticleState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedArticleState) {
            return Center(
              child: Text('OK => ${state.articles.length.toString()}'),
            );
          } else if (state is ErrorArticleState) {
            return Center(
              child: Text('ERROR => ${state.message}'),
            );
          }

          return const Center(
            child: Text('ERROR DESCNOCIDO'),
          );
        },
      ),
    );
  }
}
