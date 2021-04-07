import 'package:encrypt/encrypt.dart';

class MyEncripter {
  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);
  Encrypter? encrypter;

  MyEncripter() {
    this.encrypter = Encrypter(AES(key));
  }

  String encryptAES(String text) {
    return encrypter!.encrypt(text, iv: iv).base64;
  }

  String decryptAES(String forDecrypt) {
    Encrypted enc = Encrypted.from64(forDecrypt);
    try {
      String desc = encrypter!.decrypt(enc, iv: iv);
      return desc;
    } catch (e) {
      return '';
    }
  }
}
