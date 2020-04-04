import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({Key key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.pinkAccent,
            title: Text("Notifications pages")),
        floatingActionButton: BotonFlotante(),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int numero = Provider.of<_NotificationModel>(context).numero;
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pinkAccent,
      items: [
        BottomNavigationBarItem(
            title: Text("Bones"), icon: FaIcon(FontAwesomeIcons.bone)),
        BottomNavigationBarItem(
            title: Text("Notifications"),
            icon: Stack(
              children: <Widget>[
                FaIcon(FontAwesomeIcons.bell),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  /* child: Icon(
                    Icons.brightness_1,
                    size: 8.0,
                    color: Colors.redAccent,
                  ), */
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    child: Text(
                      "$numero",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 7.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.redAccent, shape: BoxShape.circle),
                  ),
                )
              ],
            )),
        BottomNavigationBarItem(
            title: Text("Dogs"), icon: FaIcon(FontAwesomeIcons.dog))
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {
  const BotonFlotante({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: FaIcon(FontAwesomeIcons.play),
        onPressed: () {
          int numero =
              Provider.of<_NotificationModel>(context, listen: false).numero;
          numero += 1;
          Provider.of<_NotificationModel>(context, listen: false).numero =
              numero;
        });
  }
}

// Provider para la comunicación entre widgets
class _NotificationModel extends ChangeNotifier {
  int _numero = 10;

  int get numero => this._numero;

  set numero(int valor) {
    this._numero = valor;
    notifyListeners(); // Redibujar los widget donde esté escuchando
  }
}
