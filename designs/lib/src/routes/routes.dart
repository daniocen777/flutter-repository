import 'package:designs/src/pages/dashboard_page.dart';
import 'package:designs/src/pages/slideshow_page.dart';
import 'package:flutter/material.dart';

import 'package:designs/src/pages/pinterest_page.dart';
import 'package:designs/src/pages/slider_list_page.dart';
import 'package:designs/src/pages/animaciones_page.dart';
import 'package:designs/src/pages/graficas_circulares_page.dart';
import 'package:designs/src/pages/headers_page.dart';
import 'package:designs/src/pages/emergency_page.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.slideshare, 'Slideshow', SlideshowPage()),
  _Route(FontAwesomeIcons.ambulance, 'Emergencia', EmergencyPage()),
  _Route(FontAwesomeIcons.heading, 'Encabezados', HeadersPage()),
  _Route(FontAwesomeIcons.peopleCarry, 'Cuadro Animado', AnimacionesPage()),
  _Route(
      FontAwesomeIcons.circleNotch, 'Barra de Progreso', GraficasCirculares()),
  _Route(FontAwesomeIcons.pinterest, 'Pinteres', PinterestPage()),
  _Route(FontAwesomeIcons.mobile, 'Slivers', SliderListPage()),
  _Route(FontAwesomeIcons.thList, 'Slivers', DashboardPage()),
];

class _Route {
  final IconData icon;
  final String title;
  final Widget page;

  _Route(this.icon, this.title, this.page);
}
