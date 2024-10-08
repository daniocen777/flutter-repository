import 'package:go_router/go_router.dart';

import '../../presentation/screen/home/home_screen.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      }),
  GoRoute(
    path: '/',
    redirect: (_, __) => '/home/0',
  )
]);
