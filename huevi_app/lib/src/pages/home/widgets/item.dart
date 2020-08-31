import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ItemHome extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool isSvg;
  final VoidCallback onPressed;

  ItemHome(
      {Key key,
      this.imagePath,
      this.title,
      this.description,
      this.onPressed,
      this.isSvg = false})
      : super(key: key);

  @override
  _ItemHomeState createState() => _ItemHomeState();
}

class _ItemHomeState extends State<ItemHome> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CupertinoButton(
          onPressed: widget.onPressed,
          padding: EdgeInsets.zero,
          child: AspectRatio(
              aspectRatio: 12 / 3,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black12, blurRadius: 10.0)
                    ]),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: widget.isSvg
                          ? WebsafeSvg.asset(
                              widget.imagePath,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              widget.imagePath,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.title,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(
                              height: 5.0,
                            ),
                            Expanded(
                              child: Text(widget.description,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
