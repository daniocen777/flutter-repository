import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/authentication_repository.dart';
import '../../../routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () async {
                // No es necesario esperar signOut
                context.read<AuthenticationRepository>().signOut();
                Navigator.pushReplacementNamed(context, Routes.signIn);
              },
              child: const Text('Sign out'))),
    );
  }
}
