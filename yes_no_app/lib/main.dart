import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/themes/app_theme.dart';
import 'presentation/providers/chat_provider.dart';
import 'presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Yes, No App',
          theme: AppTheme().theme(),
          home: const ChatScreen()),
    );
  }
}
