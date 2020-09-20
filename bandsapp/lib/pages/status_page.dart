import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:bandsapp/services/socket_service.dart';

/* Estado del servidor socket */
class StatusPage extends StatelessWidget {
  static final route = 'status';
  const StatusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          elevation: 1.0,
          onPressed: () {
            socketService.socket.emit('emitir-mensaje',
                {'nombre': 'Flutter', 'mensaje': 'Mensaje desde flutter'});
          }),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Server status: ${socketService.serverStatus}')
          ],
        ),
      ),
    );
  }
}
