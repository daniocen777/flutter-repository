import 'package:Whatsappclone/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:Whatsappclone/global/environment.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  conectarSocket() async {
    final String token = await AuthService.getToken();
    // Dart client
    this._socket = IO.io(Environments.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
    });
  }

  void desconectarSocket() {
    this._socket.disconnect();
  }
}
