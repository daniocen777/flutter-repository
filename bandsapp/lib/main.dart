import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:bandsapp/services/socket_service.dart';
import 'package:bandsapp/pages/home_page.dart';
import 'package:bandsapp/pages/status_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: HomePage.route,
        routes: {
          HomePage.route: (BuildContext context) => HomePage(),
          StatusPage.route: (BuildContext context) => StatusPage()
        },
      ),
    );
  }
}
