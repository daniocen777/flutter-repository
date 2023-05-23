import 'package:flutter/material.dart';
import 'package:my_widgets/facebook_ui/widgets/circle_button.dart';
import 'package:my_widgets/icons/suctom_icons.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap => Como el Row, pero si contenido no cabe, coloca widget debajo
    // FittedBox => Escala el tamaño evitando overflow
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            _QuickButton(
              iconData: CustomIcons.photos,
              color: Color(0xff93BE87),
              label: 'Galería',
            ),
            SizedBox(width: 15.0),
            _QuickButton(
              iconData: CustomIcons.userFriends,
              color: Color(0xff2880D4),
              label: 'Amigos',
            ),
            SizedBox(width: 15.0),
            _QuickButton(
              iconData: CustomIcons.videoCamera,
              color: Color(0xffFB7171),
              label: 'En Vivo',
            )
          ],
        ),
      ),
    );
  }
}

class _QuickButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String label;

  const _QuickButton({
    super.key,
    required this.iconData,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25.0),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleButton(
            color: color.withOpacity(0.6),
            iconData: iconData,
          ),
          const SizedBox(width: 15.0),
          Text(
            label,
            style: TextStyle(color: color),
          )
        ],
      ),
    );
  }
}
