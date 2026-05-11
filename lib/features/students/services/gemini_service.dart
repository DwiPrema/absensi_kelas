import 'package:absensi_kelas/core/constant/gemini_api_key.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final model = GenerativeModel(
    model: 'gemini-3.0-flash-preview',
    apiKey: GeminiApiKey.geminiApiKey,
  );

  Future<String> parseText(String text) async {
    final prompt =
        'Extract student data from OCR text. Return only valid JSON. Schema: [{"name": "string","roll_num": "number", "gender": "Laki-laki atau Perempuan",}]';
  }
}
