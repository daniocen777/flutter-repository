import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posts_clean_architecture/core/app_theme.dart';
import 'package:posts_clean_architecture/features/posts/presentation/blocs/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:posts_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.getIt<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.getIt<AddDeleteUpdatePostsBloc>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Clean Architecture',
            theme: appTheme,
            home: const PostsPage()));
  }
}
