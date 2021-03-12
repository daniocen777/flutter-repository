part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class MensajeParaEvent extends ChatEvent {
  final Usuario usuarioPara;

  MensajeParaEvent(this.usuarioPara);
}

class OnRecuperarMensajesEvent extends ChatEvent {
  final String usuarioId;

  OnRecuperarMensajesEvent(this.usuarioId);
}
