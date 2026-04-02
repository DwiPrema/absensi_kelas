import 'dart:typed_data';

import 'package:absensi_kelas/core/constant/api_google_ai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

///SERVICE UNTUK HIT API GEMINI AI
class GeminiService {
  final _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest', apiKey: GoogleAIApp.apiKey);

  Future<String?> requestAIAnalysis(String prompt, Uint8List imageBytes) async {
    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', imageBytes),
      ])
    ];

    final response = await _model.generateContent(content);

    return response.text;
  }
}
