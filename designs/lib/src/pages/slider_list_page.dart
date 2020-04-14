import 'package:flutter/material.dart';

class SliderListPage extends StatelessWidget {
  const SliderListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MainScroll(),
          Positioned(bottom: -10.0, right: 0.0, child: _ButtonNewList())
        ],
      ),
    );
  }
}

class _ButtonNewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ButtonTheme(
      minWidth: size.width * 0.7,
      height: 100.0,
      child: RaisedButton(
        color: Color(0xffED6762),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0))),
        onPressed: () {
          print('Tap button');
        },
        child: Text(
          'CREATE NEW LIST',
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0),
        ),
      ),
    );
  }
}

class MainScroll extends StatelessWidget {
  final items = [
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        /* SliverAppBar(
          floating: true,
          elevation: 0.0,
          backgroundColor: Colors.deepPurple,
          title: Text('Holas mundos'),
        ), */
        SliverPersistentHeader(
            floating: true,
            delegate: _SliverCustomHeaderDelegate(
              minHeight: 170,
              maxHeight: 200,
              child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: _HeaderTitle(),
              ),
            )),
        SliverList(
            delegate:
                SliverChildListDelegate([...items, SizedBox(height: 100.0)]))
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // implement build
    return SizedBox.expand(child: child);
  }

  @override
  // implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverCustomHeaderDelegate oldDelegate) {
    // implement shouldRebuild => Redibujar
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _HeaderTitle extends StatelessWidget {
  const _HeaderTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 30.0),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Text(
          'New',
          style: TextStyle(
            color: Color(0xff532128),
            fontSize: 50.0,
          ),
        ),
      ),
      Stack(
        children: <Widget>[
          SizedBox(width: 100.0),
          Positioned(
            bottom: 8.0,
            child: Container(
              width: 120.0,
              height: 8.0,
              decoration: BoxDecoration(color: Color(0xffF7CDD5)),
            ),
          ),
          Container(
            child: Text(
              'List',
              style: TextStyle(
                  color: Color(0xffD93A30),
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )
    ]);
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final Color color;

  const _ListItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(30.0),
      height: 130.0,
      decoration: BoxDecoration(
          color: this.color, borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        this.title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }
}
