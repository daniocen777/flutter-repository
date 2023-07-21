import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = context.read();
    final user = sessionController.state!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.id.toString(),
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              user.username,
              style: const TextStyle(fontSize: 20.0),
            ),
            TextButton(
                onPressed: () async {
                  // No es necesario esperar signOut
                  // context.read<AuthenticationRepository>().signOut();
                  await sessionController
                      .signOut(); // Rstablecer el estado en null
                  // No se puede usar context luego de un await (usar mounted)
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, Routes.signIn);
                  }
                },
                child: const Text('Sign out')),
          ],
        ),
      ),
    );
  }
}
