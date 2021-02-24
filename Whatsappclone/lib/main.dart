import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Whatsappclone/routes/routes.dart';
import 'package:Whatsappclone/utils/colors.dart';
import 'package:Whatsappclone/blocs/auth/auth_bloc.dart';
import 'package:Whatsappclone/blocs/socket/socket_bloc.dart';
import 'package:Whatsappclone/blocs/chat/chat_bloc.dart';
import 'package:Whatsappclone/pages/loading_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthBloc()),
        BlocProvider(create: (BuildContext context) => SocketBloc()),
        BlocProvider(create: (BuildContext context) => ChatBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: PRIMARY_COLOR,
          accentColor: SECOND_COLOR,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: LoadingPage.route,
        routes: routes,
      ),
    );
  }
}
