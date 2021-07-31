import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../data/data.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../widgets/custom_drawer_option.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Stack(children: [
        Image(
            width: double.infinity,
            height: 200.0,
            image: AssetImage(currentUser.backgroundImageUrl!),
            fit: BoxFit.cover),
        Positioned(
            bottom: 20.0,
            left: 20.0,
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3.0, color: Theme.of(context).primaryColor)),
                  child: ClipOval(
                      child: Image(
                          image: AssetImage(currentUser.profileImageUrl!),
                          fit: BoxFit.cover))),
              SizedBox(width: 6.0),
              Text(currentUser.name!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5))
            ]))
      ]),
      CustomDraweroption(
          icon: CupertinoIcons.home,
          title: 'Inicio',
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()))),
      CustomDraweroption(
          icon: CupertinoIcons.chat_bubble_2,
          title: 'Chats',
          onTap: () => print('Chats')),
      CustomDraweroption(
          icon: CupertinoIcons.person,
          title: 'Perfil',
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ProfilePage(user: currentUser)))),
      CustomDraweroption(
          icon: CupertinoIcons.gear_alt,
          title: 'Herramientas',
          onTap: () => print('Herramientas')),
      Expanded(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: CustomDraweroption(
                  icon: CupertinoIcons.square_arrow_left,
                  title: 'Cerrar sesión',
                  onTap: () => print('Cerrar'))))
    ]));
  }
}
