import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: const TextStyle(color: Colors.black),
      title: const Text('Favorites'),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      bottom: TabBar(
          controller: tabController,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          indicator: const _Decoration(color: Colors.blueAccent, width: 20.0),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.black,
          tabs: const [
            Tab(
              text: 'Movies',
            ),
            Tab(
              text: 'Series',
            ),
          ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  final Color color;
  final double width;

  const _Decoration({required this.color, required this.width});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _Painter(color, width);
}

class _Painter extends BoxPainter {
  _Painter(this.color, this.width);

  final Color color;
  final double width;

  @override
  void paint(
    Canvas canvas, // lugar (espacio de trabajo, donde se dibuja)
    Offset offset, // posición del indicator
    ImageConfiguration
        configuration, // datos del tap (saber dimensiones del tab)
  ) {
    final paint = Paint()..color = color; // pincel
    final size = configuration.size ?? Size.zero;
    // Rectángulo
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * 0.5 + offset.dx - width * 0.5,
            size.height * 0.9,
            width,
            width * 0.3,
          ),
          const Radius.circular(4.0)),
      paint,
    );
    // Círculo
    /* canvas.drawCircle(
      Offset(size.width * 0.5 + offset.dx, size.height * 0.9),
      4.0,
      paint,
    ); */
  }
}
