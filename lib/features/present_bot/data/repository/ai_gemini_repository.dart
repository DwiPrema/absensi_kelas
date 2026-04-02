import 'dart:typed_data';
import 'dart:convert';
import 'package:absensi_kelas/features/present_bot/data/models/ai_student_model.dart';
import 'package:absensi_kelas/features/present_bot/data/services/ai_gemini_service.dart';

class GeminiRepository {
  final GeminiService _geminiService;

  GeminiRepository(this._geminiService);

  Future<List<AIStudentModel>> getScannedStudentData(Uint8List bytes) async {
    const prompt = """
      Analisis foto daftar siswa ini. 
      Ekstrak data: Nama, NIS, NISN, dan Nomor Absen (roll_num).
      Aturan:
      1. Jika NIS, NISN, atau Nomor Absen tidak ditemukan/tidak terbaca, isi dengan null.
      2. Nama WAJIB ada.
      3. Berikan hasil HANYA dalam format JSON array: 
      [{"name": "...", "nis": "...", "nisn": "...", "roll_num": "..."}]
    """;

    final rawJson = await _geminiService.requestAIAnalysis(prompt, bytes);

    if (rawJson == null) return [];

    final cleanJson =
        rawJson.replaceAll('```json', '').replaceAll('```', '').trim();

    final List<dynamic> decoded = jsonDecode(cleanJson);
    return decoded.map((item) => AIStudentModel.fromJson(item)).toList();
  }
}
