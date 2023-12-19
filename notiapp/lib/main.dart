import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routers/app_router.dart';
import 'core/themes/app_theme.dart';
import 'injection_container.dart' as di;
import 'presentation/blocs/article/article_bloc.dart';
import 'presentation/blocs/counter/counter_bloc.dart';
import 'presentation/blocs/employee/employee_bloc.dart';

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
            create: (_) => di.getIt<ArticleBloc>()..add(GetAllArticleEvent())),
        BlocProvider(create: (_) => di.getIt<CounterBloc>()),
        BlocProvider(
            create: (_) => di.getIt<EmployeeBloc>()..add(GetEmployeesEvent()))
      ],
      child: MaterialApp.router(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        routerConfig: appRouter,
      ),
    );
  }
}
