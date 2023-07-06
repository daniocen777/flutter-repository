import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Asegurar que widget esté renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  Future<void> _init() async {
    final injector = Injector.of(context);
    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hasInterner;
    if (hasInternet) {
      final authenticationRepository = injector.authenticationRepository;
      if (await authenticationRepository.isSignedIn) {
        // Recuperar datos del usuario
        final user = await authenticationRepository.getUserData();
        // Asegurar que widget está renderizado (por el contexto)
        if (mounted) {
          if (user != null) {
            _goTo(Routes.home);
          } else {
            _goTo(Routes.signIn);
          }
        }
      }
      // Asegurar que widget está renderizado (por el contexto)
      else if (mounted) {
        _goTo(Routes.signIn);
      }
    } else {}
  }

  void _goTo(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80.0,
          height: 80.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
