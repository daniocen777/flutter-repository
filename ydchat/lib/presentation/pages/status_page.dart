import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ydchat/presentation/widgets/status/single_item_history.dart';

import 'package:ydchat/presentation/widgets/theme/theme.dart';

/* 29.25 */

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _customFloatingActionButton(),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: <Widget>[
            _storyWidget(),
            SizedBox(
              height: 8.0,
            ),
            _recentStatus(),
            SizedBox(
              height: 8.0,
            ),
            _stories()
          ]),
        )
      ],
    ));
  }

  Widget _customFloatingActionButton() {
    return Positioned(
      right: 10.0,
      bottom: 15.0,
      child: Column(
        children: [
          Container(
            height: 45.0,
            width: 45.0,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0.0, 0.4),
                      blurRadius: 0.5,
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.1)
                ]),
            child: Center(child: FaIcon(FontAwesomeIcons.userEdit)),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
                color: secondColor,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0.0, 0.4),
                      blurRadius: 0.5,
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.1)
                ]),
            child: Center(
                child: FaIcon(
              FontAwesomeIcons.camera,
              color: Colors.white,
            )),
          )
        ],
      ),
    );
  }

  Widget _storyWidget() {
    return Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0),
        child: Row(children: <Widget>[
          Container(
            width: 55.0,
            height: 55.0,
            child: Stack(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Image.asset('assets/profile_default.png'),
              ),
              Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: secondColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                          size: 12.0,
                        ),
                      )))
            ]),
          ),
          SizedBox(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mi Estado',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 2.0,
              ),
              Text('Presiona para actualizar estado'),
            ],
          )
        ]));
  }

  Widget _recentStatus() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Text('Estados actualizados'),
    );
  }

  Widget _stories() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return SingleItemStory();
      },
    );
  }
}
