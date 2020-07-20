import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;

  const CategoryCard({Key key, this.svgSrc, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(13.0)),
      child: Column(
        children: <Widget>[
          Spacer(),
          SvgPicture.asset(this.svgSrc),
          Spacer(),
          Text(
            this.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}
