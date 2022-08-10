import 'package:amazon_clone/features/auth/screens/login_screen.dart';
import 'package:amazon_clone/global_widgets/rounded_button.dart';
// import 'package:amazon_clone/features/auth/screens/register_screen.dart';
// import 'package:amazon_clone/features/auth/widgets/choiser_widget.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  static const String route = 'auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = context.read<AuthBloc>();
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, state) {
          if (state.loading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                    text: "Cambiar estado",
                    onPressed: () => authBloc.add(LoadingEvent())),
                const CircularProgressIndicator()
              ],
            );
          }
          return const Scaffold(body: SafeArea(child: LoginScreen()));
        },
        buildWhen: (prevState, newState) =>
            prevState.loading != newState.loading);
  }
}
