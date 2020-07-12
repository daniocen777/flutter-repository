import 'package:diaryapp/src/bloc/provider.dart';
import 'package:diaryapp/src/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:diaryapp/src/pages/lock_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Diary SQLite',
          theme: myTheme,
          home: LockPage()),
    );
  }
}
