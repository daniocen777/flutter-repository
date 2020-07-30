import 'package:cupertinoapp/src/widgets/video-item-shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeTabShimmer extends StatelessWidget {
  const HomeTabShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 120.0,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return Shimmer(
                period: Duration(milliseconds: 2000),
                gradient: LinearGradient(colors: <Color>[
                  Colors.white,
                  Colors.grey,
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            color: Color(0xffcccccc), shape: BoxShape.circle),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Container(
                          width: 50.0, height: 13.0, color: Color(0xffdddddd))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
          child: Text('Para Flutter devs',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        ),
        AspectRatio(
          aspectRatio: 8 / 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(3, (int index) {
                return Container(
                  width: size.width * 0.75,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black12, blurRadius: 10.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Shimmer.fromColors(
                              baseColor: Color(0xfff0f0f0),
                              highlightColor: Color(0xffcccccc),
                              child: Container(color: Color(0xffcccccc)))),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Shimmer.fromColors(
                              baseColor: Color(0xffcccccc),
                              highlightColor: Color(0xffaaaaaa),
                              child: Container(
                                  width: 100.0,
                                  height: 15.0,
                                  color: Colors.black26),
                            ),
                            Shimmer.fromColors(
                              baseColor: Color(0xffcccccc),
                              highlightColor: Color(0xffaaaaaa),
                              child: Container(
                                  width: double.infinity,
                                  height: 15.0,
                                  margin: EdgeInsets.only(top: 5.0),
                                  color: Colors.black26),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(6, (int index) {
              return VideoItemShimmer();
            }))
      ],
    );
  }
}
