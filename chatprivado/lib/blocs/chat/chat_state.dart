part of 'chat_bloc.dart';

@immutable
class ChatState {
  final Usuario usuario;
  final List<Mensaje> mensajes;

  ChatState({this.usuario, this.mensajes});

  ChatState copyWith({Usuario usuario, List<Mensaje> mensajes}) {
    return ChatState(
        usuario: usuario ?? this.usuario, mensajes: mensajes ?? this.mensajes);
  }
}
