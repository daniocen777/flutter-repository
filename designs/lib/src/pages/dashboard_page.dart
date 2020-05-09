import 'package:designs/src/widgets/headers_widget.dart';
/* import 'package:designs/src/widgets/item_dashboard.dart'; */
import 'package:designs/src/widgets/item_dashboard_2.dart';
import 'package:flutter/material.dart';
/* import 'package:font_awesome_flutter/font_awesome_flutter.dart'; */

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HeaderCuadradoGradiente(),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  width: double.infinity,
                  child: SafeArea(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Bienvenido',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        Spacer(),
                        CircleAvatar(
                            radius: 25.0,
                            backgroundImage:
                                AssetImage('assets/images/dog.jpg'))
                      ],
                    ),
                  ),
                ),
                Table(children: <TableRow>[
                  TableRow(children: [
                    ItemDashboard2(
                      title: 'Calendar',
                      imageUrl: 'assets/svgs/star.svg',
                      onPress: () => print('Calendar'),
                    ),
                    ItemDashboard2(
                      title: 'Reportes',
                      imageUrl: 'assets/svgs/bar-chart.svg',
                      onPress: () => print('Reportes'),
                    ),
                  ]),
                  TableRow(children: [
                    ItemDashboard2(
                      title: 'Usuario',
                      imageUrl: 'assets/svgs/business.svg',
                      onPress: () => print('Usuario'),
                    ),
                    ItemDashboard2(
                      title: 'Cancelar',
                      imageUrl: 'assets/svgs/signs.svg',
                      onPress: () => print('Cancelar'),
                    ),
                  ]),
                  TableRow(children: [
                    ItemDashboard2(
                      title: 'Reportes',
                      imageUrl: 'assets/svgs/star.svg',
                      onPress: () => print('Calendar'),
                    ),
                    ItemDashboard2(
                      title: 'Reportes',
                      imageUrl: 'assets/svgs/star.svg',
                      onPress: () => print('Calendar'),
                    ),
                  ]),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
