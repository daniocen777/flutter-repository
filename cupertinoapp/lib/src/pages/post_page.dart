import 'package:cupertinoapp/src/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  static final routename = 'post';

  PostPage({Key key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<String> _data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              MyAppBar(
                leftIcon: 'assets/icons/back.svg',
                rightIcon: 'assets/icons/comment.svg',
                onLeftClick: () => Navigator.pop(context),
                onRightClick: () {
                  setState(() {
                    _data.add('Item ${DateTime.now()}');
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String item = _data[index];
                    return ListTile(
                      title: Text(item),
                      subtitle: Text('Subtitle'),
                      onLongPress: () {
                        setState(() {
                          _data.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
