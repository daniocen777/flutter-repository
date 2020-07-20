import 'package:cupertinoapp/src/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class ImagePageArgs {
  final String username;
  final bool isActive;

  ImagePageArgs({@required this.username, @required this.isActive});
}

class ImagePage extends StatefulWidget {
  static final routename = 'images';

  ImagePage({Key key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    /* ImagePageArgs args = ModalRoute.of(context).settings.arguments; */
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              MyAppBar(
                leftIcon: 'assets/icons/back.svg',
                rightIcon: 'assets/icons/comment.svg',
                onLeftClick: () => Navigator.pop(context),
              ),
              Expanded(
                  child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.black12,
                    alignment: Alignment.center,
                    child: Text('$index'),
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
