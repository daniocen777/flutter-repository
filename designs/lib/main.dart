import 'package:flutter/material.dart';

import 'package:designs/src/pages/emergency_page.dart';
/* import 'package:designs/src/pages/pinterest_page.dart'; */

/* import 'package:designs/src/pages/slideshow_page.dart'; */

/* import 'package:designs/src/pages/graficas_circulares_page.dart'; */
/* import 'package:designs/src/labs/circular_progress_page.dart'; */
/* import 'package:designs/src/pages/animaciones_page.dart'; */
/* import 'package:designs/src/pages/headers_page.dart'; */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diseños App',
        home: EmergencyPage());
  }
}
