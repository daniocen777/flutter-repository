import 'package:flutter/widgets.dart';

import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/pages/loading_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  LoginPage.route: (_) => LoginPage(),
  RegisterPage.route: (_) => RegisterPage(),
  LoadingPage.route: (_) => LoadingPage(),
  UsuariosPage.route: (_) => UsuariosPage(),
  ChatPage.route: (_) => ChatPage(),
};
