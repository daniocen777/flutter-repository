import 'package:designs/src/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:designs/src/widgets/pinterest_menu.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _MenuModel(),
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          PinterestGrid(),
          _PinterestMenuLocation(),
        ],
      )),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    bool mostrar = Provider.of<_MenuModel>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Positioned(
        bottom: 30.0,
        child: Container(
          width: width,
          child: Align(
            child: PinterestMenu(
              mostrar: mostrar,
              backgroundColor: appTheme.scaffoldBackgroundColor,
              activeColor: appTheme.accentColor,
              items: [
                PinterestButton(
                    icon: Icons.pie_chart,
                    onPress: () {
                      print('Icon pie_chart');
                    }),
                PinterestButton(
                    icon: Icons.search,
                    onPress: () {
                      print('Icon search');
                    }),
                PinterestButton(
                    icon: Icons.notifications,
                    onPress: () {
                      print('Icon notifications');
                    }),
                PinterestButton(
                    icon: Icons.supervised_user_circle,
                    onPress: () {
                      print('Icon supervised_user_circle');
                    })
              ],
              /* backgroundColor: Colors.red, */
              /* activeColor: Colors.red,
              inactiveColor: Colors.blue, */
            ),
          ),
        ));
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (i) => i);
  ScrollController controller = new ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      // Cuando se baja, el número aumenta
      /* print('Scroll listenet ${controller.offset}'); */
      if (controller.offset > scrollAnterior && controller.offset > 150.0) {
        // Ocultar menú
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        // Mostrar menú
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }
      scrollAnterior = controller.offset;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StaggeredGridView.countBuilder(
      controller: controller,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(
        index: index,
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;
  const _PinterestItem({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        ));
  }
}

// Provider para notificar al listener para mostrar el menú

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => this._mostrar;

  set mostrar(bool valor) {
    this._mostrar = valor;
    notifyListeners();
  }
}
