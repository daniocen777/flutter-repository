import 'package:flutter/material.dart';
import 'package:huevi_app/src/widgets/appbar_widget.dart';

class VideosPage extends StatefulWidget {
  static final route = 'videos';
  VideosPage({Key key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              MyAppBar(
                leftIcon: 'assets/icons/back.svg',
                rightIcon: 'assets/icons/comment.svg',
                size: size,
                onRightClick: () {},
                onLeftClick: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
