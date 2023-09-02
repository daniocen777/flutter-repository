import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/connectivity_repository.dart';
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
      final ConnectivityRepository connectivityRepository = context.read();

      final hasInternet = await connectivityRepository.hasInternet;
      if (!hasInternet) {
        return Routes.offline;
      } else {
        return Routes.home;
      }
    }();

    _goTo(routeName);
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
