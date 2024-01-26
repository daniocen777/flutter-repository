part of 'router.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final preferences = sl<SharedPreferences>();
      return _pageBuilder(
        // Colocar aca el BlocProvider
        (context) {
          if (preferences.getBool(kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              profilePic: user.photoURL,
              bio: user.displayName,
              points: 0,
              fullName: user.displayName ?? '',
            );
            // context.read<UserProvider>().initUser(localUser);
            // Ver context_extension
            context.userProvider.initUser(localUser);
            return const DashboardScreen();
          }
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );

    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );

    case '/forgot-password':
      return _pageBuilder((_) => const fui.ForgotPasswordScreen(),
          settings: settings,);

    case DashboardScreen.routeName:
      return _pageBuilder((_) => const DashboardScreen(), settings: settings);

    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

// Paginas con nuestra propia animacion
PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
