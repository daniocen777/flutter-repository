import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../data/data.dart';
import '../config/palette.dart';
import '../widgtes/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
      SliverAppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text('Facebook',
            style: TextStyle(
                color: Palette.facebookBlue,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2)),
        centerTitle: false,
        floating: true,
        actions: [
          CircleButton(
              onTap: () => print('Buscar'), icon: CupertinoIcons.search),
          CircleButton(
              onTap: () => print('Buscar'), icon: CupertinoIcons.chat_bubble)
        ],
      ),
      SliverToBoxAdapter(child: CreatePostContainer(currentUser: currentUser)),
      SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(child: Rooms(onlineUsers: onlineUsers))),
      SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
              child: Stories(currentUser: currentUser, stories: stories)))
    ]));
  }
}
