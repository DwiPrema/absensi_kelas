import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiApiKey {
  static String get geminiApiKey => dotenv.get('GEMINI_API_KEY', fallback: "");
}
