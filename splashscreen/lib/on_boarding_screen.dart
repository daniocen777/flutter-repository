import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import './consts/colors.dart';
import './labels/custom_label.dart';
import 'package:splashscreen/widgets/texter.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _current = 0;
  final CarouselController _controller = new CarouselController();
  static List<String> _textsList = [
    "¿Cuál es tu nombre?",
    "¿Dónde naciste?",
    "¿Qué habilidades tienes?"
  ];
  Color _color = PRIMARY_COLOR;
  String _imageUrl = 'assets/1.svg';

  final List<Widget> textsSlider =
      _textsList.map((item) => _texter(item)).toList();

  static Widget _texter(String heading) {
    return TexterWidget(heading: heading);
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      Container(
        height: _size.height,
        decoration: BoxDecoration(color: _color),
      ),
      SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: SizedBox(
                  width: _size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_back_ios_outlined,
                            color: Colors.white),
                        Text(
                          'Registrarse',
                          style: CustomLabels.h2.copyWith(color: Colors.white),
                        ),
                        Icon(Icons.menu, color: Colors.white),
                      ])))),
      Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 65.0),
        child: WebsafeSvg.asset(_imageUrl,
            width: _size.width * 0.8, height: _size.height * 0.4),
      )),
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            alignment: Alignment.bottomCenter,
            child: CarouselSlider(
                carouselController: _controller,
                items: textsSlider,
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                        switch (_current) {
                          case 0:
                            _color = PRIMARY_COLOR;
                            _imageUrl = 'assets/1.svg';
                            break;
                          case 1:
                            _color = SECOND_COLOR;
                            _imageUrl = 'assets/2.svg';
                            break;
                          case 2:
                            _color = THIRD_COLOR;
                            _imageUrl = 'assets/3.svg';
                            break;
                          default:
                            _color = PRIMARY_COLOR;
                            _imageUrl = 'assets/1.svg';
                            break;
                        }
                      });
                    },
                    enableInfiniteScroll: false,
                    reverse: false,
                    height: _size.height * 0.40,
                    viewportFraction: 1))),
      ])
    ]));
  }
}
