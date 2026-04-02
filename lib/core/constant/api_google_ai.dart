import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API KEY GOOGLE AI STUDIO
class GoogleAIApp {
  static String get apiKey => dotenv.get('API_KEY', fallback: '');
}