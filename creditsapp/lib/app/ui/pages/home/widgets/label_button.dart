import 'package:creditsapp/app/domain/inputs/student.dart';
import 'package:flutter/material.dart';

import 'package:flutter_meedu/screen_utils.dart';

class LabelButton extends StatelessWidget {
  final Student student;
  final VoidCallback? onPressed;

  const LabelButton({Key? key, required this.student, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isThemeDark = context.isDarkMode;
    final iconColor = isThemeDark ? Colors.white30 : Colors.black45;

    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      onPressed: () {
        // Para que el color sea igual
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              student.name,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min, // para que no ocupe todo el espacio
            children: [
              Text('Horas: ' + student.hours.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 12.0)),
              const SizedBox(width: 7.0),
              Text('Minutos: ' + student.minutes.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 12.0)),
              const SizedBox(width: 7.0),
              Text('Créditos: ' + student.credits.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12.0)),
              const SizedBox(width: 7.0),
              if (onPressed != null)
                Icon(Icons.chevron_right_rounded, size: 22.0, color: iconColor)
            ],
          ),
        ],
      ),
    );
  }
}
