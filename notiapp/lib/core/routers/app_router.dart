import 'package:go_router/go_router.dart';

import '../../presentation/screens/home_screen.dart';
import '../constans/page_index_and_name.dart';

final appRouter = GoRouter(
  initialLocation: '/home/${PageIndexAndName.homeViewIndex}',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: 'home',
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        print('******** $pageIndex ***********');
        return HomeScreen(pageIndex: pageIndex);
      },
    ),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/${PageIndexAndName.homeViewIndex}',
    ),
  ],
);
