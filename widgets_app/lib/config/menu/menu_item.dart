import 'package:flutter/material.dart' show IconData, Icons;

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Botones',
    subTitle: 'Botones variados',
    link: '/buttons',
    icon: Icons.smart_button_outlined,
  ),
  MenuItem(
    title: 'Tarjetas',
    subTitle: 'Contenedor estilizados',
    link: '/cards',
    icon: Icons.credit_card_outlined,
  ),
  MenuItem(
    title: 'Progress Indicators',
    subTitle: 'Generales y controlados',
    link: '/progress',
    icon: Icons.refresh_rounded,
  ),
  MenuItem(
    title: 'Snackbars y diálogos',
    subTitle: 'Indicadores',
    link: '/snackbar',
    icon: Icons.info_outline,
  ),
  MenuItem(
    title: 'Animated Container',
    subTitle: 'Statefull animado',
    link: '/animated',
    icon: Icons.check_box_outline_blank,
  ),
  MenuItem(
    title: 'UI Controls + Tiles',
    subTitle: 'Serie de controladores',
    link: '/ui-controls',
    icon: Icons.car_crash_outlined,
  ),
  MenuItem(
    title: 'Intro a la app',
    subTitle: 'Tutorial introductorio de la app',
    link: '/tutorial',
    icon: Icons.accessible_rounded,
  ),
];
