import 'package:flutter/material.dart';
import 'package:noticiasapp/src/pages/tabs_page.dart';
import 'package:noticiasapp/src/services/new_service.dart';
import 'package:noticiasapp/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new NewService(),
      child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: myTheme,
          home: TabsPage()),
    );
  }
}
