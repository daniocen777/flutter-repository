import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario; // Punto activo
  final Color colorSecundario; // Punto desactivo
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow(
      {Key key,
      @required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.blue,
      this.colorSecundario = Colors.grey,
      this.bulletPrimario = 12.0,
      this.bulletSecundario = 12.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _SlideshowModel(),
      child: SafeArea(
        child: Center(child: Builder(
          builder: (BuildContext context) {
            Provider.of<_SlideshowModel>(context).colorPrimario =
                this.colorPrimario;
            Provider.of<_SlideshowModel>(context).colorSecundario =
                this.colorSecundario;

            Provider.of<_SlideshowModel>(context).bulletPrimario =
                this.bulletPrimario;
            Provider.of<_SlideshowModel>(context).bulletSecundario =
                this.bulletSecundario;

            return _EstructuraSlideshow(
                puntosArriba: puntosArriba, slides: slides);
          },
        )),
      ),
    );
  }
}

class _EstructuraSlideshow extends StatelessWidget {
  const _EstructuraSlideshow({
    Key key,
    @required this.puntosArriba,
    @required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (this.puntosArriba) _Dots(this.slides.length),
        Expanded(child: _Sildes(this.slides)),
        if (!this.puntosArriba) _Dots(this.slides.length),
      ],
    );
  }
}

/* Indicadores de imágenes => Puntos */
class _Dots extends StatelessWidget {
  final int totalSlide;

  _Dots(this.totalSlide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.0,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(this.totalSlide, (i) => _Dot(index: i))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideshowModel = Provider.of<_SlideshowModel>(context);
    double currentPage = Provider.of<_SlideshowModel>(context).currentPage;
    if (currentPage == null) {
      currentPage = 0;
    }
    double size = 0;
    Color color;

    if (currentPage >= index - 0.5 && currentPage < index + 0.5) {
      size = slideshowModel.bulletPrimario;
      color = slideshowModel.colorPrimario;
    } else {
      size = slideshowModel.bulletSecundario;
      color = slideshowModel.colorSecundario;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Sildes extends StatefulWidget {
  final List<Widget> slides;
  _Sildes(this.slides);

  @override
  __SildesState createState() => __SildesState();
}

class __SildesState extends State<_Sildes> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
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
      children: widget.slides.map((slide) => _Silde(slide)).toList(),
    ));
  }
}

class _Silde extends StatelessWidget {
  final Widget slide;

  const _Silde(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30.0),
        child: slide);
  }
}

// Modelo para trabajar con el Provider
class _SlideshowModel with ChangeNotifier {
  double _currentPage;
  Color _colorPrimario;
  Color _colorSecundario;
  double _bulletPrimario;
  double _bulletSecundario;

  double get currentPage => this._currentPage;
  Color get colorPrimario => this._colorPrimario;
  Color get colorSecundario => this._colorSecundario;
  double get bulletPrimario => this._bulletPrimario;
  double get bulletSecundario => this._bulletSecundario;

  set currentPage(double pagina) {
    this._currentPage = pagina;
    notifyListeners();
  }

  set colorPrimario(Color color) {
    this._colorPrimario = color;
  }

  set colorSecundario(Color color) {
    this._colorSecundario = color;
  }

  set bulletPrimario(double bullet) {
    this._bulletPrimario = bullet;
  }

  set bulletSecundario(double bullet) {
    this._bulletSecundario = bullet;
  }
}
