import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

import '../../../core/constants/environment.dart';

class MarvelAPIConfig {
  static final timestamp = DateTime.now().millisecondsSinceEpoch;
  static final publicKey = Environment.publicKey;
  static final privateKey = Environment.privateKey;

  static String _getHash() {
    String hashDecoded = timestamp.toString() + privateKey + publicKey;
    var md5 = crypto.md5;
    return md5.convert(utf8.encode(hashDecoded)).toString();
  }

  static Map<String, String> getQueryParams() {
    Map<String, String> securityQueryParams = {
      'ts': timestamp.toString(),
      'apikey': publicKey,
      'hash': _getHash(),
    };

    return securityQueryParams;
  }
}
