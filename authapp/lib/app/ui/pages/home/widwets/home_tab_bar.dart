import 'package:flutter/material.dart';

import 'package:flutter_meedu/screen_utils.dart';
import 'package:authapp/app/ui/pages/home/home_page.dart';

class HomeTabBar extends StatelessWidget {
  HomeTabBar({Key? key}) : super(key: key);

  final _homeController = homeProvider.read;

  @override
  Widget build(BuildContext context) {
    /* Usar el contexto creado para el tema (no hace falta usar Consumer) */
    final isThemeDark = context.isDarkMode;
    final color = isThemeDark ? const Color(0xffd81b60) : Colors.blueAccent;
    return SafeArea(
        top: false,
        /* Usar Consumer para escuchar el tema y cambiar de color del tabBar */
        child: TabBar(
          controller: _homeController.tabController,
          unselectedLabelColor: isThemeDark ? Colors.white30 : Colors.black26,
          indicator: _CustomIndicator(color),
          labelColor: color,
          tabs: const [
            Tab(
                icon: Icon(
              Icons.home_rounded,
            )),
            Tab(
                icon: Icon(
              Icons.person_rounded,
            ))
          ],
        ));
  }
}

class _CustomIndicator extends Decoration {
  final Color _color;

  const _CustomIndicator(this._color);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(_color);
  }
}

class _CirclePainter extends BoxPainter {
  final Color _color;

  _CirclePainter(this._color);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint(); // pincel
    paint.color = _color;
    // Dibujando un círculo
    final size = configuration.size!;
    final center = Offset(offset.dx + size.width * 0.5, size.height * 0.8);
    canvas.drawCircle(center, 3.0, paint);
  }
}
