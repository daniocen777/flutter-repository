import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/account_repository.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../global/controllers/session_controller.dart';
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
    final routeName = await () async {
      // Una manera
      /* final connectivityRepository =
          Provider.of<ConnectivityRepository>(context, listen: false); */
      // Otra manera, usando read (de paquerte Provider)
      final ConnectivityRepository connectivityRepository = context.read();
      // final injector = Injector.of(context);
      // final connectivityRepository = injector.connectivityRepository;
      /* final authenticationRepository =
          Provider.of<AuthenticationRepository>(context, listen: false); */
      final AuthenticationRepository authenticationRepository = context.read();
      final AccountRepository accountRepository = context.read();
      // Para los estados globales
      final SessionController sessionController = context.read();

      final hasInternet = await connectivityRepository.hasInternet;
      if (!hasInternet) {
        return Routes.offline;
      }

      final isSignedIn = await authenticationRepository.isSignedIn;
      if (!isSignedIn) {
        return Routes.signIn;
      }
      final user = await accountRepository.getUserData();
      // Guardar el estado global con sessionController
      if (user != null) {
        sessionController.setUser(user);
        return Routes.home;
      }
      return Routes.signIn;
    }();
    if (mounted) {
      _goTo(routeName);
    }
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
