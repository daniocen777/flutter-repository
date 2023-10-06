import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../views.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    // cargar
    isLoading = true;
    final movies =
        await ref.read(favoritesMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoitesMovies = ref.watch(favoritesMoviesProvider).values.toList();
    return Scaffold(
        body: MovieMasondy(
      loadNextPage: loadNextPage,
      movies: favoitesMovies,
    ));
  }
}
