import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memes/src/blocs/memes/memes_bloc_bloc.dart';

import 'package:memes/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MemesBlocBloc()),
      ],
      child: MaterialApp(
        title: 'Memes app',
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routename,
        routes: {HomePage.routename: (BuildContext context) => HomePage()},
      ),
    );
  }
}
