import 'package:flutter/foundation.dart'; // Importar de foundation (no de material)

/* En los controladores, NUNCA USAR widgets (vistas, context, etc) */
class SignInController extends ChangeNotifier {
  String _username = '';
  String _password = '';
  bool _fetching = false;
  bool _mounted = true;

  String get username => _username;
  String get password => _password;
  bool get fetching => _fetching;
  bool get mounted => _mounted;

  void onUsernameChanged(String text) {
    _username = text.trim().toLowerCase();
  }

  void onPasswordChanged(String text) {
    _password = text.replaceAll(' ', '');
  }

  void onFetchingChanged(bool value) {
    _fetching = value;
    // Notificar el cambio a la vista
    notifyListeners();
  }

  // Sobreescribir
  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
