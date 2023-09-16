import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (_, __) => const HomeScreen(),
      // Rutas hijas => para poder regresar a la ruta padre
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (_, state) {
            final movieID = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(
              movieId: movieID,
            );
          },
        ),
      ]),
]);
