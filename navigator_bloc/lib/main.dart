import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:navigator_bloc/blocs/master/master_bloc.dart';
import 'package:navigator_bloc/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MasterBloc(),
      child: GestureDetector(
        /* Para el teclado del ios, minimizarlo al hacer tap */
        onTap: () {
          final FocusScopeNode focusScopeNode = FocusScope.of(context);
          if (!focusScopeNode.hasPrimaryFocus) {
            focusScopeNode.unfocus();
          }
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Navigator App',
            routes: {
              HomePage.routename: (BuildContext context) => HomePage(),
            },
            home: HomePage()),
      ),
    );
  }
}
