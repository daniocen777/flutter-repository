import 'package:flutter/material.dart';

import '../../config/helpers/get_yes_no_answer.dart';
import '../../domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> messages = [
    Message(text: 'Holas mundos', fromWho: FromWho.me),
    Message(text: '¿Regrrsaste?', fromWho: FromWho.me),
  ];
  // Controlador para el scroll del ListView.builder
  final chatScrollController = ScrollController();
  // respuesta
  final getYesNoAnswer = GetYesNoAnswer();

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messages.add(newMessage);
    if (text.endsWith('?')) {
      herReply();
    }
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messages.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    // pisition, duration, tivo de animacion
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
