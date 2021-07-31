import 'package:flutter/material.dart';

import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

import '../../consts/colors.dart';
import '../../providers/dark_theme_provider.dart';
import '../../consts/my_icons.dart';
import 'widgets/user_title.dart';
import 'widgets/user_list_tile.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ScrollController? _scrollController;
  var top = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final _themeProvider = Provider.of<DarkThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 4,
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              accentColor,
                              backgroundColor,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: top <= 110.0 ? 1.0 : 0,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: kToolbarHeight / 1.8,
                                    width: kToolbarHeight / 1.8,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image:
                                            ExactAssetImage('assets/user.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    // 'top.toString()',
                                    'Guest',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        background: Image(
                          image: ExactAssetImage('assets/user.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(12.0),
                          child: UserTitle(title: 'User Information')),
                      Divider(thickness: 1, color: Colors.grey),
                      UserListTile(
                        title: 'Correo',
                        subTitle: 'danicode@mail.com',
                        icon: MyAppIcons.email,
                        onTap: () => print('Correo'),
                      ),
                      UserListTile(
                        title: 'Teléfono',
                        subTitle: '9889233333',
                        icon: MyAppIcons.phone,
                        onTap: () => print('Teléfono'),
                      ),
                      Padding(
                          padding: EdgeInsets.all(12.0),
                          child: UserTitle(title: 'Herramientas')),
                      Divider(thickness: 1, color: Colors.grey),
                      ListTileSwitch(
                        value: _themeProvider.darkTheme,
                        leading: MyAppIcons.moon,
                        onChanged: (value) {
                          setState(() {
                            _themeProvider.darkTheme = value;
                          });
                        },
                        visualDensity: VisualDensity.comfortable,
                        switchType: SwitchType.cupertino,
                        switchActiveColor: accentColor,
                        title: Text('Tema oscuro'),
                      ),
                      UserListTile(
                        title: 'Cerrar sesión',
                        subTitle: '',
                        icon: MyAppIcons.signOut,
                        onTap: () => print('Cerrar sesión'),
                      ),
                    ],
                  ),
                )
              ],
            ),
            _buildFab()
          ],
        ),
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 180.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController!.hasClients) {
      double offset = _scrollController!.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {},
          child: MyAppIcons.camera,
        ),
      ),
    );
  }
}
