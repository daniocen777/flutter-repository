import 'package:authapp/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:authapp/app/ui/global_widgets/dialogs/show_input_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/state.dart';

import '../../../../utils/dark_mode_extension.dart';
import 'package:authapp/app/ui/global_controllers/session_controller.dart';
import 'package:authapp/app/ui/global_controllers/theme_controller.dart';

/* Widget que extienda de ConsumerWidget para que se reconstruya al actualizar los datos*/
class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  void _updateDisplayName(BuildContext context) async {
    final sessionController = sessionProvider.read;
    final value = await showInputDialog(context,
        initialValue: sessionController.user!.displayName ?? '');
    if (value != null) {
      ProgressDialog.show(context);
      final user = await sessionController.updateDisplayName(value);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(context, title: 'Error', content: 'Error de conexión');
      }
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    // Escuchar los cambio de la sesión y del tema
    final sessionController = ref.watch(sessionProvider);
    /* Usar el contexto creado para el tema (no hace falta usar Consumer) */
    final isThemeDark = context.isThemeDarkMode;
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
        _LabelButton(
            label: 'Nombre',
            value: displayName,
            onPressed: () => _updateDisplayName(context)),
        _LabelButton(label: 'Correo', value: user.email ?? ''),
        _LabelButton(
            label: 'Correo verificado',
            value: user.emailVerified ? 'Sí' : 'No'),
        CupertinoSwitch(
            value: isThemeDark,
            onChanged: (_) {
              themeProvider.read.toggle();
            })
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
    final isThemeDark = context.isThemeDarkMode;
    final iconColor = isThemeDark ? Colors.white30 : Colors.black45;
    return ListTile(
      onTap: onPressed,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
      leading: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // para que no ocupe todo el espacio
        children: [
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.w300, fontSize: 14.0)),
          const SizedBox(width: 7.0),
          Icon(
            Icons.chevron_right_rounded,
            size: 22.0,
            color: onPressed != null ? iconColor : Colors.transparent,
          )
        ],
      ),
    );
  }
}
