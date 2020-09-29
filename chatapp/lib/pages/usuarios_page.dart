import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chatapp/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  static final route = 'usuarios';

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'María', email: 'mari@gmail.com', online: true),
    Usuario(uid: '2', nombre: 'Lalo', email: 'lalocura@mail.com', online: true),
    Usuario(uid: '3', nombre: 'Ana', email: 'anita@outlook.com', online: false),
    Usuario(
        uid: '4', nombre: 'Pedro', email: 'elperro@gmail.com', online: false),
    Usuario(uid: '5', nombre: 'Keka', email: 'gorda@gmail.com', online: true)
  ];

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context);
    final Usuario _usuario = _authService.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(_usuario.nombre, style: TextStyle(color: Colors.black87)),
          elevation: 1.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black87),
            onPressed: () {
              // Desconectar del socket server
              AuthService.deleteToken();
              Navigator.pushReplacementNamed(context, LoginPage.route);
            },
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0),
              /* child: Icon(Icons.check_circle, color: Colors.blue[400]), */
              child: Icon(Icons.offline_bolt, color: Colors.red[400]),
            )
          ],
        ),
        body: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _cargarUsuarios,
            header: WaterDropHeader(
              complete: Icon(Icons.check, color: Colors.blue[400]),
              waterDropColor: Colors.blue[400],
            ),
            child: _usuariosListView(usuarios)));
  }

  ListView _usuariosListView(List<Usuario> usuarios) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: usuarios.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) =>
            _itemUsuario(usuarios[index]));
  }

  ListTile _itemUsuario(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: usuario.online ? Colors.green[300] : Colors.red[400])),
    );
  }

  void _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
