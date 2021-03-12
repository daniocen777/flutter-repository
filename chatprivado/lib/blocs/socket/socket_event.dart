part of 'socket_bloc.dart';

@immutable
abstract class SocketEvent {}

class OnConnectEvent extends SocketEvent {}

class OnDisconnectEvent extends SocketEvent {}

class OnEnviarmensajeEvent extends SocketEvent {
  final String idUsuarioPara;
  final String idUsuarioDe;
  final String mensaje;

  OnEnviarmensajeEvent(this.idUsuarioPara, this.idUsuarioDe, this.mensaje);
}
