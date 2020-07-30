import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VideoItemShimmer extends StatelessWidget {
  const VideoItemShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 12 / 3,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 10.0)
        ]),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Shimmer.fromColors(
                    baseColor: Color(0xfff0f0f0),
                    highlightColor: Color(0xffcccccc),
                    child: Container(color: Color(0xffeeeeee)))),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Color(0xfff0f0f0),
                      highlightColor: Color(0xffcccccc),
                      child: Container(
                          width: double.infinity,
                          height: 12.0,
                          color: Color(0xffeeeeee)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Shimmer.fromColors(
                      baseColor: Color(0xfff0f0f0),
                      highlightColor: Color(0xffcccccc),
                      child: Container(
                          width: double.infinity,
                          height: 20.0,
                          color: Color(0xffeeeeee)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
