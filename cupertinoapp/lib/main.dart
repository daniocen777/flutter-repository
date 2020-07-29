import 'package:cupertinoapp/src/blocs/master/master_bloc.dart';
import 'package:flutter/material.dart';

import 'package:cupertinoapp/src/pages/home_page.dart';
import 'package:cupertinoapp/src/pages/login_page.dart';
import 'package:cupertinoapp/src/pages/post_page.dart';
import 'package:cupertinoapp/src/pages/image_page.dart';
import 'package:cupertinoapp/src/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Todo bloc necesita cerrarse, pero "BlocProvider" lo tiene implementado,
    a diferencia de "BlocProvider.value (como se usó en la página Login)" */
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
            title: 'Material App',
            routes: {
              ImagePage.routename: (BuildContext context) => ImagePage(),
              HomePage.routename: (BuildContext context) => HomePage(),
              PostPage.routename: (BuildContext context) => PostPage(),
              LoginPage.routename: (BuildContext context) => LoginPage()
            },
            home: SplashPage()),
      ),
    );
  }
}
