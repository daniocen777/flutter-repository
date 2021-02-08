import 'dart:async';

import 'package:Whatsappclone/services/socket_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketBloc() : super(SocketState());

  final _socketService = new SocketService();

  SocketService get socketService => _socketService;

  @override
  Stream<SocketState> mapEventToState(
    SocketEvent event,
  ) async* {
    if (event is OnConnectEvent) {
      _socketService.conectarSocket();
      yield state.copyWith(conectado: true);
    } else if (event is OnDisconnectEvent) {
      _socketService.desconectarSocket();
      yield state.copyWith(conectado: false);
    } else if (event is OnEnviarmensajeEvent) {
      _socketService.emit('mensaje-personal', {
        'de': event.idUsuarioDe,
        'para': event.idUsuarioPara,
        'mensaje': event.mensaje
      });
      yield state.copyWith(
          idUsuarioDe: event.idUsuarioDe,
          idUsuarioPara: event.idUsuarioPara,
          mensaje: event.mensaje);
    }
  }
}
