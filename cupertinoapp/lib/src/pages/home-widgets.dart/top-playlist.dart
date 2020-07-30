import 'package:cupertinoapp/src/pages/playlist-videos_page.dart';
import 'package:cupertinoapp/src/utils/extras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertinoapp/src/models/playlist_model.dart';

class TopPlayList extends StatefulWidget {
  final List<PlayList> items;

  TopPlayList({Key key, @required this.items})
      : assert(items != null && items.length > 0),
        super(key: key);

  @override
  _TopPlayListState createState() => _TopPlayListState();
}

class _TopPlayListState extends State<TopPlayList> {
  PageController _pageController = PageController(initialPage: 0);
  ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    /* _pageController.addListener(() {
      print('_controller');
    }); */
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10.0, bottom: 10.0),
          child: Text('Para Flutter devs',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        ),
        AspectRatio(
          aspectRatio: 8 / 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollNotification) {
                  final int page =
                      (_pageController.position.pixels / size.width).round();
                  _currentPage.value = page;
                }
                return false;
              },
              child: ListView(
                controller: _pageController,
                physics: CustomScrollPhysics(itemDimension: 200.0),
                scrollDirection: Axis.horizontal,
                children: List.generate(widget.items.length, (int index) {
                  final PlayList item = widget.items[index];
                  return Container(
                    width: size.width * 0.75,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    margin: EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black12, blurRadius: 10.0)
                        ]),
                    child: CupertinoButton(
                      onPressed: () {
                        final route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PlayListVideoPage(
                                  playListId: item.id,
                                ));
                        Navigator.push(context, route);
                      },
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: CachedNetworkImage(
                            imageUrl: item.banner,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(item.title,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(Extras.fromNow(item.publishedAt),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                        )),
                                    Text('Videos: ${item.itemCount}',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        /* CupertinoButton(
            child: Text('Prev page'),
            onPressed: () {
              _pageController.animateTo((_currentPage.value - 1) * size.width,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            }),
        CupertinoButton(
            child: Text('Next page'),
            onPressed: () {
              _pageController.animateTo((_currentPage.value + 1) * size.width,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            }), */
        /* ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (BuildContext context, int value, Widget child) {
            return Dots(
              count: widget.items.length,
              currentPage: value,
            );
          },
        ) */
      ],
    );
  }
}

class Dots extends StatelessWidget {
  final int count;
  final int currentPage;

  const Dots({Key key, @required this.count, @required this.currentPage})
      : assert(count != null && count > 0),
        assert(currentPage != null && currentPage >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: (currentPage == index) ? Colors.black : Colors.black12,
                  shape: BoxShape.circle));
        }));
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  CustomScrollPhysics({this.itemDimension, ScrollPhysics parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position, double portion) {
    return (position.pixels + portion) / itemDimension;
  }

  double _getPixels(double page, double portion) {
    return (page * itemDimension) - portion;
  }

  double _getTargetPixels(
    ScrollPosition position,
    Tolerance tolerance,
    double velocity,
    double portion,
  ) {
    double page = _getPage(position, portion);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble(), portion);
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);

    final Tolerance tolerance = this.tolerance;
    final portion = (position.extentInside - itemDimension) / 2;
    final double target =
        _getTargetPixels(position, tolerance, velocity, portion);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
