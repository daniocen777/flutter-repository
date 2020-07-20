import 'package:daily_exercises_app/src/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:daily_exercises_app/src/constants/colors_constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Cairo',
            scaffoldBackgroundColor: BACKGROUND_COLOR,
            textTheme:
                Theme.of(context).textTheme.apply(displayColor: TEXT_COLOR)),
        title: 'Material App',
        home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.45,
            decoration: BoxDecoration(
                color: Color(0xfff5ceb8),
                image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    image:
                        AssetImage('assets/images/undraw_pilates_gpdb.png'))),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => print('Width: $size.width'),
                      child: Container(
                        alignment: Alignment.center,
                        width: 52.0,
                        height: 52.0,
                        decoration: BoxDecoration(
                            color: Color(0xfff2bea1), shape: BoxShape.circle),
                        child: SvgPicture.asset('assets/icons/menu.svg'),
                      ),
                    ),
                  ),
                  Text(
                    'Good Morning \nxxx',
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  if (size.width < 500)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29.5)),
                      child: TextField(
                        decoration: InputDecoration(
                            icon: SvgPicture.asset('assets/icons/search.svg'),
                            border: InputBorder.none,
                            hintText: 'Search'),
                      ),
                    ),
                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      children: <Widget>[
                        CategoryCard(
                          title: 'Diet Recomendation',
                          svgSrc: 'assets/icons/Hamburger.svg',
                        ),
                        CategoryCard(
                          title: 'Diet Recomendation',
                          svgSrc: 'assets/icons/Hamburger.svg',
                        ),
                        CategoryCard(
                          title: 'Diet Recomendation',
                          svgSrc: 'assets/icons/Hamburger.svg',
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
