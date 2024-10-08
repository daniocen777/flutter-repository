import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String publicKey = dotenv.env['PUBLIC_KEY'] ?? 'No KEY';
  static String privateKey = dotenv.env['PRIVATE_KEY'] ?? 'No KEY';
}
