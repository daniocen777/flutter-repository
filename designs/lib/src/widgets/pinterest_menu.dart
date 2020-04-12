import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  final Function onPress;
  final IconData icon;

  PinterestButton({@required this.onPress, @required this.icon});
}

class PinterestMenu extends StatelessWidget {
  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor; // black
  final Color inactiveColor; // bluegrey
  final List<PinterestButton> items;

  PinterestMenu(
      {this.mostrar = true,
      this.backgroundColor = Colors.white,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.blueGrey,
      @required this.items});

  /* final List<PinterestButton> items = [
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
  ]; */

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => new _MenuModel(),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 250),
          opacity: (mostrar) ? 1 : 0,
          child: Builder(
            builder: (BuildContext context) {
              Provider.of<_MenuModel>(context).backgroundColor =
                  this.backgroundColor;
              Provider.of<_MenuModel>(context).activeColor = this.activeColor;
              Provider.of<_MenuModel>(context).inactiveColor =
                  this.inactiveColor;
              return _PinteresMenuBackground(
                  child: _MenuItems(menuItems: items));
            },
          ),
        ));
  }
}

class _PinteresMenuBackground extends StatelessWidget {
  final Widget child;
  const _PinteresMenuBackground({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;
    return Container(
      child: child,
      width: 250.0,
      height: 60.0,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38, blurRadius: 10.0, spreadRadius: -5.0)
          ]),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;
  const _MenuItems({Key key, this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
            menuItems.length, (i) => _PinterestMenuButton(i, menuItems[i])));
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final index;
  final PinterestButton item;

  const _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);
    final itemSeleccionado = menuModel.itemSeleccionado;
    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).itemSeleccionado =
            index;
        item.onPress();
      },
      // behavior => Para que todos los dispositivos lo reconozca
      behavior: HitTestBehavior.translucent,
      child: Container(
          child: Icon(item.icon,
              size: (itemSeleccionado == index) ? 35.0 : 25.0,
              color: (itemSeleccionado == index)
                  ? menuModel.activeColor
                  : menuModel.inactiveColor)),
    );
  }
}

/* CLase para comunicar a los íconos a quién se hizo el tap => Provider */

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color backgroundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;

  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado(int index) {
    this._itemSeleccionado = index;
    notifyListeners();
  }
}
