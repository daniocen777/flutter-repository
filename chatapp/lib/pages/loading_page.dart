import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  static final route = 'loading';
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this._checkLoguinState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(child: Text('Cargando...'));
        },
      ),
    );
  }

  Future _checkLoguinState(BuildContext context) async {
    //  listen: false => No redibujar la pantalla
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketervice = Provider.of<SocketService>(context, listen: false);
    final bool authenticated = await authService.isLogin(context);
    if (authenticated) {
      // Conectar con el socket
      socketervice.connect();
      // Conectar al socket
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  UsuariosPage()));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  LoginPage()));
    }
  }
}
