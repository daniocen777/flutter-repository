import 'package:flutter/material.dart';
import 'package:designs/src/widgets/slideshow.dart';
import 'package:flutter_svg/svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bulletPrimario => Tamaño del punto activo
    // bulletSecundario => Tamaño del punto desactivo
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(child: _MiSlideshow()),
        Expanded(child: _MiSlideshow()),
      ],
    ));
  }
}

class _MiSlideshow extends StatelessWidget {
  const _MiSlideshow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slideshow(
      colorPrimario: Colors.purpleAccent,
      bulletPrimario: 15,
      bulletSecundario: 10,
      slides: <Widget>[
        SvgPicture.asset('assets/svgs/slide-1.svg'),
        SvgPicture.asset('assets/svgs/slide-2.svg'),
        SvgPicture.asset('assets/svgs/slide-3.svg'),
        SvgPicture.asset('assets/svgs/slide-4.svg'),
        SvgPicture.asset('assets/svgs/slide-5.svg'),
      ],
    );
  }
}
