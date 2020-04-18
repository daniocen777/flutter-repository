import 'package:flutter/material.dart';

import 'package:designs/src/models/layout_model.dart';
import 'package:designs/src/theme/theme.dart';
import 'package:designs/src/routes/routes.dart';
import 'package:provider/provider.dart';

class LauncherTabletPage extends StatelessWidget {
  const LauncherTabletPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final layoutModel = Provider.of<LayoutModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Diseños Flutter - Tablet'),
        backgroundColor: appTheme.currentTheme.accentColor,
      ),
      drawer: _MenuPrincipal(),
      body: Row(
        children: <Widget>[
          // Lista de opciones con un tamaño
          Container(
            width: 270.0,
            height: double.infinity,
            child: _ListaOpciones(),
          ),
          Container(
            width: 1.0,
            height: double.infinity,
            color: (appTheme.darkTheme)
                ? Colors.grey
                : appTheme.currentTheme.accentColor,
          ),
          Expanded(child: layoutModel.currentPage)
        ],
      ),
      /*  body: _ListaOpciones(), */
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: pageRoutes.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: appTheme.primaryColorLight),
      itemBuilder: (BuildContext context, int index) => ListTile(
        leading: Icon(pageRoutes[index].icon, color: appTheme.accentColor),
        title: Text(pageRoutes[index].title),
        trailing: Icon(Icons.chevron_right, color: appTheme.accentColor),
        onTap: () {
          /* Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => pageRoutes[index].page)); */
          final layoutModel = Provider.of<LayoutModel>(context, listen: false);
          layoutModel.currentPage = pageRoutes[index].page;
        },
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.accentColor;
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
//                padding: EdgeInsets.only(20.0),
                width: double.infinity,
                height: 120.0,
                child: CircleAvatar(
                  backgroundColor: accentColor,
                  child: Text('YD',
                      style: TextStyle(
                        fontSize: 50.0,
                      )),
                ),
              ),
            ),
            Expanded(
              child: _ListaOpciones(),
            ),
            ListTile(
                leading: Icon(
                  Icons.lightbulb_outline,
                  color: accentColor,
                ),
                title: Text('Dark Mode'),
                trailing: Switch.adaptive(
                    value: appTheme.darkTheme,
                    activeColor: accentColor,
                    onChanged: (value) => appTheme.darkTheme = value)),
            SafeArea(
              bottom: true,
              top: false,
              left: false,
              right: false,
              child: ListTile(
                  leading: Icon(
                    Icons.add_to_home_screen,
                    color: accentColor,
                  ),
                  title: Text('Custom theme'),
                  trailing: Switch.adaptive(
                      value: appTheme.customTheme,
                      activeColor: accentColor,
                      onChanged: (value) => appTheme.customTheme = value)),
            )
          ],
        ),
      ),
    );
  }
}
