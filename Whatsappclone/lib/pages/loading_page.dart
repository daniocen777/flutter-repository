import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Whatsappclone/blocs/socket/socket_bloc.dart';
import 'package:Whatsappclone/blocs/auth/auth_bloc.dart';
import 'package:Whatsappclone/pages/usuarios_page.dart';
import 'package:Whatsappclone/pages/login_page.dart';

class LoadingPage extends StatefulWidget {
  static String route = 'loading';

  const LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final socketBloc = BlocProvider.of<SocketBloc>(context);
    authBloc.add(OnRenovarTokenEvent());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        if (state.cargando) {
          return Scaffold(
              body: Container(
                  child: Center(
                      child: CupertinoActivityIndicator(
            radius: 12.0,
          ))));
        } else if (state.online) {
          socketBloc.add(OnConnectEvent());
          return UsuariosPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
