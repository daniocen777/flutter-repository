import 'package:flutter/material.dart';

import '../constants/style.dart';
import '../helpers/responsive.dart';
import '../widgets/custom_text.dart';

class TopBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TopBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: !ResponsiveWidwet.isSmallScreen(context)
            ? Row(children: [
                Container(
                    padding: const EdgeInsets.only(left: 14.0),
                    height: 100,
                    child: Image.asset('assets/icons/logo.png', width: 28.0))
              ])
            : IconButton(
                onPressed: () => this.scaffoldKey.currentState!.openDrawer(),
                icon: Icon(Icons.menu)),
        elevation: 0.0,
        title: Row(children: [
          Visibility(
              child: CustomerText(
            text: 'Dashboard',
            color: lightGrey,
            size: 20.0,
            fontWeight: FontWeight.bold,
          )),
          Expanded(child: Container()),
          IconButton(
              onPressed: () => print('Settings'),
              icon: Icon(Icons.settings, color: dark.withOpacity(0.7))),
          Stack(
            children: [
              IconButton(
                  onPressed: () => print('Notificaciones'),
                  icon:
                      Icon(Icons.notifications, color: dark.withOpacity(0.7))),
              Positioned(
                  top: 7.0,
                  right: 7.0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: light, width: 2.0)),
                  ))
            ],
          ),
          Container(width: 1.0, height: 22.0, color: lightGrey),
          const SizedBox(width: 24.0),
          CustomerText(text: 'Danicode', color: lightGrey),
          const SizedBox(width: 16.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
                padding: const EdgeInsets.all(2.0),
                margin: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                    backgroundColor: light,
                    child: Icon(Icons.person_outline, color: dark))),
          )
        ]),
        iconTheme: IconThemeData(color: dark),
        backgroundColor: Colors.transparent);
  }
}
