import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/state.dart';

/* Widget que extienda de ConsumerWidget para que se reconstruya al actualizar los datos*/
class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // Escuchar los cambio de la sesión
    final sessionController = ref.watch(sessionProvider);
    final user = sessionController.user!;
    final displayName = user.displayName ?? '';
    final letter = displayName.isNotEmpty ? displayName[0] : '';
    return ListView(      
      children: [
        const SizedBox(height: 20.0),
        CircleAvatar(
            radius: 75.0,
            child: user.photoURL == null
                ? Text(
                    letter,
                    style: const TextStyle(fontSize: 64.0),
                  )
                : null,
            backgroundImage:
                user.photoURL != null ? NetworkImage(user.photoURL!) : null),
        const SizedBox(height: 10.0),
        Center(
            child: Text(
          displayName,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        )),
        Center(child: Text(user.email ?? '')),
        const SizedBox(height: 50.0),
        // const Text('Datos del usuario'),
        _LabelButton(label: 'Nombre', value: displayName, onPressed: () {}),
        _LabelButton(label: 'Correo', value: user.email ?? ''),
        _LabelButton(
            label: 'Correo verificado',
            value: user.emailVerified ? 'Sí' : 'No'),
      ],
    );
  }
}

class _LabelButton extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onPressed;

  const _LabelButton(
      {Key? key, required this.label, required this.value, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      leading: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // para que no ocupe todo el espacio
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14.0)),
          const SizedBox(width: 7.0),
          Icon(
            Icons.chevron_right_rounded,
            size: 22.0,
            color: onPressed != null ? Colors.black45 : Colors.transparent,
          )
        ],
      ),
    );
  }
}
