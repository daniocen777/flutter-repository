part of 'socket_bloc.dart';

@immutable
class SocketState {
  final bool conectado;
  final String idUsuarioPara;
  final String idUsuarioDe;
  final String mensaje;

  SocketState(
      {this.conectado = false,
      this.idUsuarioPara = '',
      this.idUsuarioDe = '',
      this.mensaje = ''});

  SocketState copyWith(
      {bool conectado,
      String idUsuarioPara,
      String idUsuarioDe,
      String mensaje}) {
    return SocketState(
        conectado: conectado ?? this.conectado,
        idUsuarioPara: idUsuarioPara ?? this.idUsuarioPara,
        idUsuarioDe: idUsuarioDe ?? this.idUsuarioDe,
        mensaje: mensaje ?? this.mensaje);
  }
}
