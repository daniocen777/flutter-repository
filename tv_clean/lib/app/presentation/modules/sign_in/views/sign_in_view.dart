import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../routes/routes.dart';

class SigInView extends StatefulWidget {
  const SigInView({super.key});

  @override
  State<SigInView> createState() => _SigInViewState();
}

class _SigInViewState extends State<SigInView> {
  String _username = '';
  String _password = '';
  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // AbsorbPointer => Para bloquear widget
          child: AbsorbPointer(
            absorbing: _fetching,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (text) {
                    setState(() {
                      _username = text.trim().toLowerCase();
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Username'),
                  validator: (text) {
                    text = text?.trim().toLowerCase() ?? '';
                    if (text.isEmpty) {
                      return 'Invalid username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (text) {
                    setState(() {
                      _password = text.replaceAll(' ', '');
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Password'),
                  validator: (text) {
                    text = text?.replaceAll(' ', '') ?? '';
                    if (text.length < 4) {
                      return 'Invalid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Builder(builder: (context) {
                  if (_fetching) {
                    return const CircularProgressIndicator();
                  }
                  return MaterialButton(
                    onPressed: () {
                      final isValid = Form.of(context).validate();
                      if (isValid) {
                        _submit(context);
                      }
                    },
                    color: Colors.blue,
                    child: const Text('Sign in'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  // _submit(context) => para el snackbar
  Future<void> _submit(BuildContext context) async {
    setState(() {
      _fetching = true;
    });
    final result =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .signIn(_username, _password);

    // Como se va a volver a usar 'context' en el Navigator, asegurar que vista sigue rendereizada
    if (!mounted) {
      return;
    }

    result.when((failute) {
      setState(() {
        _fetching = false;
      });
      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid Password',
        SignInFailure.unknown: 'Error',
        SignInFailure.network: 'Network error'
      }[failute];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
