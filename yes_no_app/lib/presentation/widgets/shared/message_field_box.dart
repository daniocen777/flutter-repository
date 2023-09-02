import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key, required this.onValue});

  final ValueChanged<String> onValue;

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40.0),
    );
    final inputDecoration = InputDecoration(
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true, // lleno, sombreado
      hintText: 'End your message with a "?"',
      suffixIcon: IconButton(
          onPressed: () {
            final textValue = textController.value.text;
            onValue(textValue);
            textController.clear();
          },
          icon: const Icon(
            Icons.send_outlined,
          )),
    );

    return TextFormField(
      controller: textController,
      focusNode: focusNode,
      onTapOutside: (event) => focusNode.unfocus(),
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        onValue(value);
        textController.clear();
        focusNode.requestFocus();
      },
    );
  }
}
