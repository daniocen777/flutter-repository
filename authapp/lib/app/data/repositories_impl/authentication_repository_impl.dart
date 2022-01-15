import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:authapp/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FirebaseAuth _auth;
  User? _user;
  final Completer<void> _completer = Completer();

  AuthenticationRepositoryImpl(this._auth) {
    _init(); // instancia
  }

  @override
  // TODO: implement user
  Future<User?> get user async {
    await _completer.future;
    return _user;
  }

  void _init() async {
    _auth.authStateChanges().listen((User? user) {
      if (!_completer.isCompleted) {
        _completer.complete(); // saber si se llamó, al menos una vez a listen()
      }
      _user = user;
    });
  }
}
