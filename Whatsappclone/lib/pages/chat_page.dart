import 'package:Whatsappclone/models/mensaje_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Whatsappclone/utils/colors.dart';
import 'package:Whatsappclone/widgets/chat_message.dart';
import 'package:Whatsappclone/blocs/auth/auth_bloc.dart';
import 'package:Whatsappclone/blocs/chat/chat_bloc.dart';
import 'package:Whatsappclone/blocs/socket/socket_bloc.dart';

class ChatPage extends StatefulWidget {
  static String route = 'chat';

  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textEditingController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _escribiendo = false;
  List<ChatMessage> _mensajes = [];
  ChatBloc chatBloc;
  SocketBloc socketBloc;
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    this.chatBloc = BlocProvider.of<ChatBloc>(context);
    this.socketBloc = BlocProvider.of<SocketBloc>(context);
    this.authBloc = BlocProvider.of<AuthBloc>(context);
    this.socketBloc.socketService.socket.on('mensaje-personal', (data) => null);
    print('MENSAJE PARA ==> ${chatBloc.chatService.usuarioPara.uid}');
    _cargarHistorial(chatBloc.chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioId) async {
    List<Mensaje> mensajes = await chatBloc.chatService.getChat(usuarioId);

    final historial = mensajes.map((mensaje) => ChatMessage(
          texto: mensaje.mensaje,
          uid: mensaje.de,
          animationController: new AnimationController(
              vsync: this, duration: const Duration(milliseconds: 0))
            ..forward(),
        ));

    setState(() {
      _mensajes.insertAll(0, historial);
    });
  }

  void escucharMensaje(dynamic payload) {
    ChatMessage message = new ChatMessage(
        texto: payload['mensaje'],
        uid: payload['de'],
        animationController: new AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300)));
    setState(() {
      _mensajes.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  void dispose() {
    // Cerrar animación
    for (ChatMessage message in _mensajes) {
      message.animationController.dispose();
    }
    this.socketBloc.socketService.socket.off('mensaje-personal');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final chatBloc = BlocProvider.of<ChatBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: SECOND_COLOR,
                maxRadius: 12.0,
                child: Text(
                  this.chatBloc.state.usuario.nombre.substring(0, 2),
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              Text(
                chatBloc.state.usuario.nombre,
                style: TextStyle(fontSize: 12.0, color: PRIMARY_COLOR_DARK),
              )
            ],
          )),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _mensajes.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return _mensajes[index];
                },
              ),
            ),
            Divider(height: 1.0),
            // Caja de texto
            Container(
              height: 50.0,
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: this._textEditingController,
                decoration:
                    InputDecoration.collapsed(hintText: 'Escribe el mensaje'),
                focusNode: this._focusNode,
                onSubmitted: this._handleSubmit,
                onChanged: (String texto) {
                  setState(() => (texto.trim().length > 0)
                      ? _escribiendo = true
                      : _escribiendo = false);
                },
              ),
            ),
            // Botón enviar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _escribiendo
                      ? () => _handleSubmit(_textEditingController.text.trim())
                      : null),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.trim().length == 0) return;
    this._textEditingController.clear();
    this._focusNode.requestFocus();
    final nuevoMensaje = new ChatMessage(
      uid: this.authBloc.state.usuario.uid,
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );
    _mensajes.insert(0, nuevoMensaje);
    nuevoMensaje.animationController.forward();
    // Enviar mensaje al socket
    this.socketBloc.add(OnEnviarmensajeEvent(this.chatBloc.state.usuario.uid,
        this.authBloc.state.usuario.uid, texto));
    setState(() => _escribiendo = false);
  }
}
