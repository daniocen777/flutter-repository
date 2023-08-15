import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/controllers/favorites/favorites_controller.dart';
import '../../../../utils/mark_as_favorite.dart';
import '../../controller/movie_controller.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    // saber si es favorito
    final FavoritesController favoriteController = context.watch();
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: controller.state.mapOrNull(
        loaded: (movieState) => [
          favoriteController.state.maybeMap(
            orElse: () => const SizedBox(),
            loaded: (favoritesState) => IconButton(
              onPressed: () => markAsFavorite(
                context: context,
                media: movieState.movie.toMedia(),
                mounted: () => controller.mounted,
              ),
              icon: Icon(favoritesState.movies.containsKey(movieState.movie.id)
                  ? Icons.favorite
                  : Icons.favorite_outline),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
