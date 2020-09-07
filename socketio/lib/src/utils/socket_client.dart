import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';
import 'package:socketio/src/models/chat_message.dart';

enum SocketStatus { connecting, connected, joined, disconnected, error }

class SocketClient {
  SocketClient._internal();
  static SocketClient _instance = SocketClient._internal();
  static SocketClient get instance => _instance;

  /* StreamController<SocketStatus> _statusController =
      StreamController.broadcast(); => SocketStatus.connecting.obs */
  // Observable para el status
  Rx<SocketStatus> _status = SocketStatus.connecting.obs;
  Rx<SocketStatus> get status => _status;
  // Observable para la cantidad de usuarios conectados (numUsers)
  RxInt _numUsers = 0.obs;
  RxInt get numUsers => _numUsers;
  // Observable para el envío de mensajes
  RxString _inputText = ''.obs;
  RxString get inputText => _inputText;
  // Map para la devolución de los eventos "typing" y "stop typing"
  RxMap<String, String> _typingUsers = Map<String, String>().obs;
  RxMap<String, String> get typingUsers => _typingUsers;
  // Lista para los mensajes (clase ChatMessage)
  RxList<ChatMessage> _messages = List<ChatMessage>().obs;
  RxList<ChatMessage> get messages => _messages;

  IO.Socket _socket;
  String _nickname;
  // Definiendo worker => permiten escuchar eventos (para el evento typing del socket)
  Worker _typingWorker = null;

  void init() {
    // Woerker ever => Escuchará simpre que hay un cambio en _inputText
    /*   ever(this._inputText, (_) {
      print(this._inputText.value);
    }); */
    // Woerker debounce => Escuchará el cambio después de un tiempo
    // Servirá para el evento stop typing
    debounce(this._inputText, (_) {
      // print(this._inputText.value);
      // Una vex que se deje de escribir, emitir el evento stop typing y _typingWorker = null
      this._socket?.emit('stop typing');
      this._typingWorker = null;
    }, time: Duration(milliseconds: 500));
  }

  void disconnect() {
    this._socket?.disconnect();
    this._socket = null;
  }

  void connect() {
    this._socket =
        IO.io('https://socketio-chat-h9jt.herokuapp.com', <String, dynamic>{
      'transports': ['websocket']
    });
    /* Escuchando el evento "connect" */
    this._socket.on('connect', (data) {
      this._status.value = SocketStatus.connected;
      /* this._statusController.sink.add(SocketStatus.connected); */
    });
    /* Escuchando el evento "connect_error" si hay error */
    this._socket.on('connect_error', (data) {
      this._status.value = SocketStatus.error;
      /* this._statusController.sink.add(SocketStatus.error); */
    });
    /* Escuchando el evento "disconnect" */
    this._socket.on('disconnect', (data) {
      this._status.value = SocketStatus.disconnected;
      /* this._statusController.sink.add(SocketStatus.disconnected); */
    });
    /* Escuchando el evento "login" */
    this._socket.on('login', (data) {
      // Retorna numUsers => Cantidad de usuarios conectados
      this._numUsers.value = data['numUsers'] as int;
      this._status.value = SocketStatus.joined;
      /* this._statusController.sink.add(SocketStatus.joined); */
    });
    /* Escuchando el evento "user joined" => return username numUsers */
    this._socket.on('user joined', (data) {
      this._numUsers.value = data['numUsers'] as int;
    });
    /* Escuchando el evento "typing" => return username (usuario que escribe el texto) */
    this._socket.on('typing', (data) {
      final String username = data['username'];
      this._typingUsers.add(username, username);
    });
    /* Escuchando el evento "stop typing" => return username (usuario que deja de escribe el texto) */
    this._socket.on('stop typing', (data) {
      final String username = data['username'];
      this._typingUsers.remove(username);
    });
    /* Escuchando el evento "user left" => return username (que se va) y numUsers (Cantidad de usuarios) */
    this._socket.on('user left', (data) {
      showSimpleNotification(Text('${data["username"]} left'),
          background: Colors.redAccent);
      this._numUsers.value = data['numUsers'] as int;
    });
    /* Escuchando el evento "new message" => return username y message */
    this._socket.on('new message', (data) {
      final String username = data['username'];
      final String message = data['message'];
      if (message != null && message.length > 0) {
// sender: false => Sólo escucho mensajes de terceros
        this._messages.add(
            ChatMessage(username: username, message: message, sender: false));
      }
    });
  }

  /* Evento 'add user' para unirse al chat */
  void joinToChat(String nickname) {
    this._nickname = nickname;
    this._socket?.emit('add user', nickname);
  }

  void onInputChange(String text) {
    if (this._typingWorker == null) {
      // Creando nuevo worker => once, escucha sólo el primer cambio del observable
      this._typingWorker = once(this._inputText, (_) {
        // print('Start typing');
        this._socket?.emit('typing');
      });
    }
    this._inputText.value = text;
  }

  bool sendMessage() {
    final text = this._inputText.value;
    if (text.trim().length > 0) {
      this._socket.emit('new message', text);
      this._inputText.value = ''; // Limpiando el texto
      // Añadiendo a la lista de messages
      final message =
          ChatMessage(username: this._nickname, message: text, sender: true);
      this._messages.add(message);
      return true;
    }
    return false;
  }
}
