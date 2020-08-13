import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:musicapp/src/auths/auth.dart';
import 'package:musicapp/src/blocs/home/bloc.dart';
import 'package:musicapp/src/db/app_theme.dart';
import 'package:musicapp/src/db/artist_store.dart';
import 'package:musicapp/src/pages/home/widgets/artist_picker.dart';
import 'package:musicapp/src/pages/home/widgets/home_bottom_bar.dart';

import 'package:musicapp/src/pages/home/widgets/home_header.dart';
import 'package:musicapp/src/pages/home/widgets/my_artists.dart';
import 'package:musicapp/src/pages/home/widgets/search.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc();
  final GlobalKey<InnerDrawerState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Future<void> _logOut() async {
    await ArtistStore.instance.clear();
    await MyAppTheme.instance.setTheme(false);
    await Auth.instance.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: InnerDrawer(
        key: _drawerKey,
        onTapClose: true,
        rightChild: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(onPressed: this._logOut, child: Text('Log out'))
              ],
            ),
          ),
        ),
        scaffold: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
              bottomNavigationBar: HomeBottomBar(),
              body: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  HomeHeader(drawerKey: this._drawerKey),
                  Search(),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (BuildContext context, HomeState state) {
                      if (state.status == HomeStatus.selecting) {
                        return ArtistPicker();
                      } else if (state.status == HomeStatus.ready) {
                        return MyArtists();
                      }
                      String text = '';
                      switch (state.status) {
                        case HomeStatus.checking:
                          text = 'Checking Database...';
                          break;
                        case HomeStatus.loading:
                          text = 'Loading Artists...';
                          break;
                        case HomeStatus.downloading:
                          text = 'Dowloading tracks...';
                          break;
                        default:
                          text = '';
                      }
                      return SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 10.0),
                              child: LinearProgressIndicator(),
                            ),
                            Text(text)
                          ],
                        ),
                      );
                    },
                  )
                  /* Calcular el espacio que sobra en el dispositivo */
                ],
              )),
        ),
      ),
    );
  }
}
