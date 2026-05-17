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
You are a strict OCR student table validator and parser.

MAIN TASK:
Analyze OCR text carefully.
ONLY return JSON array if the OCR text CLEARLY contains student table data.

If the OCR text is random, blurry, invalid, unrelated, unreadable,
contains mostly garbage characters, or does NOT clearly contain student data,
return exactly:

[]

STRICT OUTPUT RULES:
- Output ONLY pure JSON
- No markdown
- No explanation
- No notes
- No code block
- Never hallucinate data
- Never guess missing rows

VALID STUDENT DATA REQUIREMENTS:
The OCR must contain MULTIPLE indicators of student table data such as:
- student names
- roll numbers / attendance numbers
- NIS / NISN
- gender markers (L/P)
- table-like rows

If less than 2 indicators exist,
OR text confidence looks bad,
OR OCR is mostly random text,
return [] immediately.

DO NOT PARSE IF:
- text is nonsense
- many corrupted symbols
- random environment photo
- wall/object/room photo
- blurred image
- incomplete OCR
- mostly unrelated words
- only 1 unclear line exists
- OCR confidence appears low

DATA RULES:
- Preserve original numbers exactly
- Do not invent values
- If a value is missing use "-"
- Ignore headers and unrelated text
- Fix ONLY obvious OCR mistakes

IMPORTANT FIELD RULES:
- NIS and NISN are DIFFERENT
- Never duplicate NIS into NISN unless explicitly shown
- NISN is usually longer
- rollNum must contain numeric characters only
- Remove spaces from numbers
- Keep leading zeros

GENDER RULES:
- L => Laki-laki
- P => Perempuan
- Unknown => "-"

EXPECTED JSON:
[
  {
    "name": "string",
    "rollNum": "string",
    "nis": "string",
    "nisn": "string",
    "gender": "string"
  }
]

GOOD EXAMPLE:

OCR:
1 Made Arya 12345 9988776655 L
2 Komang Putra 223344 P

OUTPUT:
[
  {
    "name": "Made Arya",
    "rollNum": "1",
    "nis": "12345",
    "nisn": "9988776655",
    "gender": "Laki-laki"
  },
  {
    "name": "Komang Putra",
    "rollNum": "2",
    "nis": "223344",
    "nisn": "-",
    "gender": "Perempuan"
  }
]

BAD EXAMPLE:

OCR:
akshajsh #@@@ meja pintu motor
abx122 !! random blur

OUTPUT:
[]

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
