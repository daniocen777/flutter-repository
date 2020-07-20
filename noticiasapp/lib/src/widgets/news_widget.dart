import 'package:flutter/material.dart';
import 'package:noticiasapp/src/models/new_models.dart';
import 'package:noticiasapp/src/theme/theme.dart';

class NewsWidget extends StatelessWidget {
  final List<Article> news;
  const NewsWidget({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _Notice(notice: this.news[index], index: index);
      },
    );
  }
}

class _Notice extends StatelessWidget {
  final Article notice;
  final int index;

  const _Notice({Key key, @required this.notice, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10.0),
        _TopbarCard(notice: this.notice, index: index),
        _TitleCard(notice: this.notice),
        _ImageCard(notice: this.notice),
        _BodyCard(notice: this.notice),
        _ButtonsCard(),
        SizedBox(height: 10.0),
        Divider()
      ],
    );
  }
}

class _TopbarCard extends StatelessWidget {
  final Article notice;
  final int index;

  const _TopbarCard({
    Key key,
    this.notice,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text('${index + 1}. ', style: TextStyle(color: myTheme.accentColor)),
          Text('${notice.source.name}. '),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article notice;

  const _TitleCard({Key key, this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(notice.title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article notice;

  const _ImageCard({Key key, this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        child: Container(
            child: notice.urlToImage != null
                ? FadeInImage(
                    placeholder: AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage(notice.urlToImage))
                : Image(image: AssetImage('assets/img/no-image.png'))),
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  final Article notice;

  const _BodyCard({Key key, this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: (notice.description != null) ? Text(notice.description) : '');
  }
}

class _ButtonsCard extends StatelessWidget {
  const _ButtonsCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {},
          fillColor: myTheme.accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Icon(Icons.star_border),
        ),
        SizedBox(width: 10.0),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Icon(Icons.more),
        )
      ],
    ));
  }
}
