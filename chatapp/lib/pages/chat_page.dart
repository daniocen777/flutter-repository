import 'package:chatapp/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  static final route = 'chat';
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _typing = false;
  List<ChatMessage> _messages = [];

  @override
  void dispose() {
    // Socket
    // controladores
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              maxRadius: 14.0,
              child: Text('DA', style: TextStyle(fontSize: 12.0)),
            ),
            SizedBox(
              height: 3.0,
            ),
            Text('Danicode',
                style: TextStyle(fontSize: 10.0, color: Colors.black87))
          ],
        ),
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            /* child: Icon(Icons.check_circle, color: Colors.blue[400]), */
            child: Icon(Icons.offline_bolt, color: Colors.red[400]),
          )
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _messages.length,
            reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return _messages[index];
            },
          )),
          Divider(height: 1.0),
          /* Caja de texto */
          Container(color: Colors.white, child: this._inputChat())
        ],
      )),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
            focusNode: _focusNode,
            onSubmitted: _handleSubmit,
            onChanged: (String value) {
              setState(() {
                if (value.trim().length > 0) {
                  _typing = true;
                } else {
                  _typing = false;
                }
              });
            },
          )),
          // Botón de envío
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _typing
                      ? () => _handleSubmit(_textController.text)
                      : null))
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.trim().length == 0) return;
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      uid: '123',
      text: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _typing = false;
    });
  }
}
