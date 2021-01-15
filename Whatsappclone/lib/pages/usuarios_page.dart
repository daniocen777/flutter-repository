import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:Whatsappclone/models/usuario.dart';
import 'package:Whatsappclone/utils/colors.dart';

class UsuariosPage extends StatefulWidget {
  static String route = 'usuarios';

  const UsuariosPage({Key key}) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Daniel', email: 'dani@gmail.com', online: true),
    Usuario(uid: '2', nombre: 'María', email: 'mari@gmail.com', online: false),
    Usuario(uid: '3', nombre: 'Carmela', email: 'eche@gmail.com', online: true),
    Usuario(uid: '4', nombre: 'lena', email: 'lenita@gmail.com', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          title: Text('Usuario XXX', style: TextStyle(color: PRIMARY_COLOR)),
          elevation: 1.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app, color: PRIMARY_COLOR),
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.check_circle, color: SECOND_COLOR_DARK),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: PRIMARY_COLOR_LIGHT),
            waterDropColor: PRIMARY_COLOR_LIGHT,
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: usuarios.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return _userItem(usuarios[index]);
      },
    );
  }

  ListTile _userItem(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: PRIMARY_COLOR_LIGHT,
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: usuario.online ? THIRD_COLOR : SECOND_COLOR_DARK),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
