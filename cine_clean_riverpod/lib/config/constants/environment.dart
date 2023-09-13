import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDBKey = dotenv.env['THE_MOVIE_DB_KEY'] ?? 'No KEY';
}
