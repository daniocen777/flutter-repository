import 'package:flutter/cupertino.dart';

import 'package:flutter_meedu/router.dart' as router;

import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:authapp/app/ui/routes/routes.dart';

import 'package:flutter_meedu/flutter_meedu.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /* Nombre del usuario que está en el estado global.
              Usar Consumer (meedu state), ya que el nombre puede cambiar */
          Consumer(
            builder: (BuildContext context, BuilderRef ref, Widget? child) {
              // Escuchar cambios en sessionProvider
              final sessionController = ref.watch(sessionProvider);
              return Text('${sessionController.user!.displayName}');
            },
          ),
          const Text('Home'),
          const SizedBox(height: 20.0),
          CupertinoButton(
            child: const Text('Cerrar sesión'),
            onPressed: () async {
              sessionProvider.read.signOut();
              router.pushNamedAndRemoveUntil(Routes.login);
            },
          )
        ],
      ),
    );
  }
}
