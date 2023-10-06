import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (_, __) => const HomeScreen(),
  ),
  GoRoute(
    path: '/cubits',
    builder: (_, __) => const CubitCounterScreen(),
  )
]);
