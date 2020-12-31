import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/map/map_bloc.dart';
import 'blocs/my_ubication/my_ubication_bloc.dart';
import 'blocs/seach/search_bloc.dart';

import 'package:geolocate/pages/loading_page.dart';
import 'package:geolocate/pages/access-gps_page.dart';
import 'package:geolocate/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MyUbicationBloc()),
        BlocProvider(create: (BuildContext context) => MapBloc()),
        BlocProvider(create: (BuildContext context) => SearchBloc()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: LoadingPage.route,
        routes: {
          LoadingPage.route: (_) => LoadingPage(),
          AccessGpsPage.route: (_) => AccessGpsPage(),
          MapPage.route: (_) => MapPage()
        },
      ),
    );
  }
}
