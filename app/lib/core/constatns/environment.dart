import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{

  static String get apiUrl{
    return dotenv.env['API_URL'] ?? 'dadawddwasd';
  }

  static String get apiKey{
    return dotenv.env['API_KEY'] ?? '';
  }
}