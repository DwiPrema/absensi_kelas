import 'package:absensi_kelas/core/constant/gemini_api_key.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final model = GenerativeModel(
    model: 'gemini-3-flash-preview',
    apiKey: GeminiApiKey.geminiApiKey,
  );

  Future<String> parseText(String text) async {
    final prompt = '''
You are an OCR student table parser.

Your task:
Extract ALL student rows from OCR text and return ONLY valid JSON array.

STRICT RULES:
- Output must be pure JSON
- Do NOT use markdown
- Do NOT add explanation
- Do NOT add notes
- Do NOT wrap with ```json
- Return [] if no student data found

DATA RULES:
- Preserve original numbers exactly
- Do not invent missing values
- If a value is missing use "-"
- Ignore headers, titles, school names, and unrelated text
- Fix only obvious OCR mistakes

IMPORTANT FIELD RULES:
- NIS and NISN are DIFFERENT fields
- Never copy NIS into NISN unless OCR clearly shows the same value
- NISN is usually longer than NIS
- rollNum is student attendance number
- rollNum must contain only numeric characters as string
- Remove spaces from numeric values
- Keep leading zeros if they exist

GENDER RULES:
- L => Laki-laki
- P => Perempuan
- Unknown => "-"

EXPECTED JSON SCHEMA:
[
  {
    "name": "string",
    "rollNum": "string",
    "nis": "string",
    "nisn": "string",
    "gender": "string"
  }
]

EXAMPLE 1

OCR:
1 Made Arya 12345 9988776655 L

OUTPUT:
[
  {
    "name": "Made Arya",
    "rollNum": "1",
    "nis": "12345",
    "nisn": "9988776655",
    "gender": "Laki-laki"
  }
]

EXAMPLE 2

OCR:
2 Komang Putra 223344 P

OUTPUT:
[
  {
    "name": "Komang Putra",
    "rollNum": "2",
    "nis": "223344",
    "nisn": "-",
    "gender": "Perempuan"
  }
]

EXAMPLE 3

OCR:
No Nama L/P NIS NISN
1 Kadek Surya L 12345 9988123412

OUTPUT:
[
  {
    "name": "Kadek Surya",
    "rollNum": "1",
    "nis": "12345",
    "nisn": "9988123412",
    "gender": "Laki-laki"
  }
]

OCR TEXT:
<<<
$text
>>>
''';

    final content = [Content.text(prompt)];

    final response = await model.generateContent(content);

    return response.text ?? "";
  }
}
