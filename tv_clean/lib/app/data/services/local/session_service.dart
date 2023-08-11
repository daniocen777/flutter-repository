import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';
const _accountKey = 'accountId';

class SessionService {
  SessionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  Future<String?> get sessionId async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId;
  }

  // Otra forma de get (esto debido a que read y accountId tienen devuenlven el mismo tipo de dato)
  Future<String?> get accountId {
    return _secureStorage.read(key: _accountKey);
  }

  Future<void> saveSessionId(String sessionId) async {
    await _secureStorage.write(key: _key, value: sessionId);
  }

  Future<void> saveAccountId(String accountId) async {
    await _secureStorage.write(key: _accountKey, value: accountId);
  }

  Future<void> signOut() {
    return _secureStorage.deleteAll();
  }
}
