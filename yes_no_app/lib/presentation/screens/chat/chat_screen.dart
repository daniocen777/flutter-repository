import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/message.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/chat/her_message_bubble.dart';
import '../../widgets/chat/my_message_bubble.dart';
import '../../widgets/shared/message_field_box.dart';

// ...Screen => Scaffold

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Favatarfiles.alphacoders.com%2F227%2F227696.jpg&f=1&nofb=1&ipt=c34916c5dfaf4b005b537e89437de2cec0ceec3794d9bcb553d1a8bc61962e21&ipo=images'),
          ),
        ),
        title: const Text('Lover'),
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final ChatProvider chatProvider = context.watch();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messages.length,
                itemBuilder: (_, int index) {
                  final message = chatProvider.messages[index];
                  return (message.fromWho == FromWho.her)
                      ? HerMessageBubble(
                          message: message,
                        )
                      : MyMessageBubble(
                          message: message,
                        );
                },
              ),
            ),
            MessageFieldBox(onValue: chatProvider.sendMessage),
            const SizedBox(height: 20.0)
          ],
        ),
      ),
    );
  }
}
