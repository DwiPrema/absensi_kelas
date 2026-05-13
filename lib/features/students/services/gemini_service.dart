import 'package:absensi_kelas/core/constant/gemini_api_key.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final model = GenerativeModel(
    model: 'gemini-3-flash-preview',
    apiKey: GeminiApiKey.geminiApiKey,
  );

  Future<String> parseText(String text) async {
    final prompt =
        ''' 
    Extract student data from OCR text.

    Return ONLY valid JSON array.

    Rules:
      - Do not include markdown
      - Do not include explanation
      - Ignore headers, titles, and unrelated text
      - Fix minor OCR typos if obvious
      - Convert gender:
        - L = Laki-laki
        - P = Perempuan
    - If NIS or NISN is missing, use "-"
    - If gender is unknown, use "-"
    - rollNum must contain only numbers as string

    Schema:
    [
      {
        "name": "string",
        "rollNum": "string",
        "nis": "string",
        "nisn": "string",
        "gender": "string"
      }
    ]

    OCR TEXT:
    $text
''';

    final content = [Content.text(prompt)];

    final response = await model.generateContent(content);

    return response.text ?? "";
  }
}