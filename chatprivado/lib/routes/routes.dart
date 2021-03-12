import 'package:chatprivado/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:chatprivado/pages/chat_page.dart';
import 'package:chatprivado/pages/loading_page.dart';
import 'package:chatprivado/pages/register_page.dart';
import 'package:chatprivado/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  UsuariosPage.route: (_) => UsuariosPage(),
  ChatPage.route: (_) => ChatPage(),
  RegisterPage.route: (_) => RegisterPage(),
  LoadingPage.route: (_) => LoadingPage(),
  LoginPage.route: (_) => LoginPage(),
};
