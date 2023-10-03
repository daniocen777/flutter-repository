import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
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
        )
      ]),
  GoRoute(
    path: '/',
    redirect: (_, __) => '/home/0',
  ),

  // Para la navegacion, pero no guarda el estado del scroll
  /* ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
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
              )
            ]),
        GoRoute(
            path: '/favorites',
            builder: (context, state) {
              return const FavoritesView();
            }),
      ]) */
  /* GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (_, state) {
            final movieID = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(
              movieId: movieID,
            );
          },
        ), */
]);
