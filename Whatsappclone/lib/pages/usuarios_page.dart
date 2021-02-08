import 'package:Whatsappclone/blocs/chat/chat_bloc.dart';
import 'package:Whatsappclone/pages/chat_page.dart';
import 'package:Whatsappclone/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:Whatsappclone/blocs/socket/socket_bloc.dart';
import 'package:Whatsappclone/blocs/auth/auth_bloc.dart';
import 'package:Whatsappclone/utils/colors.dart';
import 'package:Whatsappclone/models/usuario.dart';
import 'package:Whatsappclone/pages/login_page.dart';

class UsuariosPage extends StatefulWidget {
  static String route = 'usuarios';

  const UsuariosPage({Key key}) : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final authService = new AuthService();

  List<Usuario> usuarios = [];

  @override
  void initState() {
    super.initState();
    this._cargarUsuarios();
  }

  @override
  void dispose() { 
    _refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final socketBloc = BlocProvider.of<SocketBloc>(context);
    final chatBloc = BlocProvider.of<ChatBloc>(context);

    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          title: Text(authBloc.state.usuario.nombre,
              style: TextStyle(color: PRIMARY_COLOR)),
          elevation: 1.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app, color: PRIMARY_COLOR),
            onPressed: () {
              print('ERROR ANTES DE NAVEGAR');
              Navigator.pushReplacementNamed(context, LoginPage.route);
              print('LOGOUT');
              authBloc.add(OnLogoutEvent());
              print('DESCONECTAR');
              socketBloc.add(OnDisconnectEvent());
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.check_circle,
                  color: (authBloc.state.online)
                      ? PRIMARY_COLOR
                      : SECOND_COLOR_DARK),
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
          child: _listViewUsuarios(chatBloc),
        ));
  }

  ListView _listViewUsuarios(ChatBloc chatBloc) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: usuarios.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return _userItem(usuarios[index], chatBloc);
      },
    );
  }

  ListTile _userItem(Usuario usuario, ChatBloc chatBloc) {
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
      onTap: () {
        chatBloc.add(MensajeParaEvent(usuario));
        Navigator.pushNamed(context, ChatPage.route);
      },
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await authService.getUsuarios();
    _refreshController.refreshCompleted();
    setState(() {});
  }
}
