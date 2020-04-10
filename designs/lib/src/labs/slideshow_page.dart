import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:designs/src/models/slider_model.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new SliderModel(),
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[Expanded(child: _Sildes()), _Dots()],
          ),
        ),
      ),
    );
  }
}

/* Indicadores de imágenes => Puntos */
class _Dots extends StatelessWidget {
  const _Dots({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _Dot(index: 0),
          _Dot(index: 1),
          _Dot(index: 2),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    if (pageViewIndex == null) {
      pageViewIndex = 0;
    }
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 12.0,
      height: 12.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
              ? Colors.blue
              : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}

class _Sildes extends StatefulWidget {
  const _Sildes({Key key}) : super(key: key);

  @override
  __SildesState createState() => __SildesState();
}

class __SildesState extends State<_Sildes> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      /* print('Página actual: ${pageViewController.page}'); */
      // Actualizar el provider (para que escuchen los demás widgets), SliderModel
      // retorna la instancia de la clase
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: <Widget>[
          _Silde(svg: "assets/svgs/slide-1.svg"),
          _Silde(svg: "assets/svgs/slide-2.svg"),
          _Silde(svg: "assets/svgs/slide-3.svg"),
        ],
      ),
    );
  }
}

class _Silde extends StatelessWidget {
  final String svg;

  const _Silde({Key key, this.svg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30.0),
      child: SvgPicture.asset(svg),
    );
  }
}
