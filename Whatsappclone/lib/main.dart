import 'package:Whatsappclone/services/push-notifications_service.dart';
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
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    final pushNotificationService = new PushNotificationService();
    pushNotificationService.initNotifications();
    pushNotificationService.messages.listen((mensaje) {
      navigatorKey.currentState.pushNamed(LoadingPage.route);
    });
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
        navigatorKey: navigatorKey,
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
