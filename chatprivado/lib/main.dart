import 'package:chatprivado/services/notifications_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chatprivado/routes/routes.dart';
import 'package:chatprivado/utils/colors.dart';
import 'package:chatprivado/blocs/auth/auth_bloc.dart';
import 'package:chatprivado/blocs/socket/socket_bloc.dart';
import 'package:chatprivado/blocs/chat/chat_bloc.dart';
import 'package:chatprivado/pages/loading_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  /* f0yRVKimTbC92Lhn8tzkMe:APA91bFv9LeN6wC02D7qY647qlrmzAOIuRDXyPR52eEuXtLMt5SzJcaJjMUlAYaA32MUFfMZZ18O7NmykcBGGHYGIKnxagccclURgT0w8r03K6c7txUqFSldclu77iyL-bcv40G-7RoJ */

  @override
  void initState() { 
    super.initState();
    final  notificationsService = NotificationsService();
    notificationsService.initNotifications();
  }

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