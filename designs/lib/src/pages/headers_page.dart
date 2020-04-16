import 'package:designs/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:designs/src/widgets/headers_widget.dart';
import 'package:provider/provider.dart';

class HeadersPage extends StatelessWidget {
  const HeadersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
final accentColor = Provider.of<ThemeChanger>(context).currentTheme.accentColor;

    return Scaffold(
      body: HeaderWave(color: accentColor,),
    );
  }
}
