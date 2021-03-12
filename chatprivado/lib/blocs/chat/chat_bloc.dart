import 'dart:async';

import 'package:chatprivado/models/mensaje_response.dart';
import 'package:chatprivado/models/usuario.dart';
import 'package:chatprivado/services/chat_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState());

  final _chatService = new ChatService();

  ChatService get chatService => _chatService;

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is MensajeParaEvent) {
      Usuario usuario = _chatService.mensajePara(event.usuarioPara);
      yield state.copyWith(usuario: usuario);
    } else if (event is OnRecuperarMensajesEvent) {
      final List<Mensaje> mensajes =
          await _chatService.getChat(event.usuarioId);
      yield state.copyWith(mensajes: mensajes);
    }
  }
}
