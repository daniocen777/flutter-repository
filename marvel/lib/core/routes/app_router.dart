import 'package:go_router/go_router.dart';

import '../../presentation/screen/home/home_screen.dart';
import '../../presentation/screen/on_boarding/on_boarding_screen.dart';

final appRouter = GoRouter(initialLocation: '/onboarding', routes: [
  GoRoute(
    path: '/onboarding',
    builder: (_, __) => const OnBoardingScreen(),
  ),
  GoRoute(
      path: '/home/:page',
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      }),
  GoRoute(
    path: '/',
    redirect: (_, __) => '/onboarding',
  )
]);
