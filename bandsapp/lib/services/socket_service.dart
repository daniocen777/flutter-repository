import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  IO.Socket _socket;

  SocketService() {
    this._initConfig();
  }

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  _initConfig() {
    // Dart client
    this._socket = IO.io('http://192.168.1.6:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });
    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.offline;
      notifyListeners();
    });
    
  }
}
