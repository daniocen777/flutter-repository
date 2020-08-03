import 'package:flutter/material.dart';
import 'package:sembast_nosql/src/db/db.dart';
import 'package:sembast_nosql/src/db/theme.dart';
import 'package:sembast_nosql/src/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* Abriendo la DB */
  await DB.instance.init();
  await MyAppTheme.instance.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    DB.instance.close(); // Cerrar la DB
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: MyAppTheme.instance,
        child: Consumer<MyAppTheme>(
            builder: (BuildContext context, myAppTheme, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sembast demo',
            theme: MyAppTheme.instance.darkEnabled
                ? ThemeData.dark()
                : ThemeData.light(),
            home: HomePage(),
          );
        }));
  }
}
