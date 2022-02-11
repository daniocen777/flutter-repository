import 'package:flutter/material.dart';

import '../../../../../utils/dark_mode_extension.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onPressed;

  const LabelButton(
      {Key? key, required this.label, required this.value, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isThemeDark = context.isThemeDarkMode;
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
              label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min, // para que no ocupe todo el espacio
            children: [
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14.0)),
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
