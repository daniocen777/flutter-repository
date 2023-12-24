import 'package:go_router/go_router.dart';

import '../../screens/login_screen.dart';
import '../../screens/welcome_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (_, __) => const WelcomeScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (_, __) => const LoginScreen(),
  )
]);
