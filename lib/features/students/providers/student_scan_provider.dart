import 'dart:convert';

import 'package:absensi_kelas/core/database/provider.dart';
import 'package:absensi_kelas/features/students/models/student_import_model.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/features/students/services/gemini_service.dart';
import 'package:absensi_kelas/features/students/services/ocr_service.dart';
import 'package:absensi_kelas/features/students/services/student_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final studentScanProvider = AsyncNotifierProvider<StudentScanNotifier, void>(
  StudentScanNotifier.new,
);

final scanLoadingTextProvider = StateProvider<String>((ref) {
  return "Memproses Data...";
});

final errorTextProvider = StateProvider<String>((ref) {
  return "Maaf, terjadi kesalahan saat scan!";
});

class StudentScanNotifier extends AsyncNotifier<void> {
  late final StudentService _studentService;

  @override
  Future<void> build() async {
    _studentService = ref.read(studentServiceProvider);
  }

  Future<String?> pickImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    return photo?.path;
  }

  Future<String?> pickImageFromGalerry() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    return photo?.path;
  }

  Future<List<StudentImportModel>?> scanImage(String path) async {
    state = const AsyncLoading();
    try {
      ref.read(scanLoadingTextProvider.notifier).state = "Membaca Data...";

      final ocr = OcrService();
      final gemini = GeminiService();

      final textOcr = await ocr.extractText(path);

      if (textOcr == null || textOcr.trim().isEmpty) {
        final error = "Maaf, text tidak terbaca dari gambar!";

        ref.read(errorTextProvider.notifier).state = error.toString();

        state = AsyncError(error, StackTrace.current);

        return null;
      }

      if (textOcr.trim().length < 15) {
        final error = "Gambar kurang jelas untuk diproses";

        ref.read(errorTextProvider.notifier).state = error.toString();

        state = AsyncError(error, StackTrace.current);

        return null;
      }

      ref.read(scanLoadingTextProvider.notifier).state = "Memproses Data...";

      final parseText = await gemini.parseText(textOcr);

      if (parseText.trim().isEmpty) {
        final error = "Gagal memproses data";

        ref.read(errorTextProvider.notifier).state = error.toString();

        state = AsyncError(error, StackTrace.current);

        return null;
      }

      dynamic jsonFormat;

      try {
        jsonFormat = jsonDecode(parseText);
      } catch (_) {
        final error = "Format data tidak valid!";

        ref.read(errorTextProvider.notifier).state = error.toString();

        state = AsyncError(error, StackTrace.current);

        return null;
      }

      if (jsonFormat is! List || jsonFormat.isEmpty) {
        final error = "Tidak ada data yang ditemukan dari gambar";

        ref.read(errorTextProvider.notifier).state = error.toString();

        state = AsyncError(error, StackTrace.current);

        return null;
      }

      final students = jsonFormat
          .map<StudentImportModel>((e) => StudentImportModel.fromJson(e))
          .toList();

      return students;
    } catch (e, s) {
      ref.read(errorTextProvider.notifier).state =
          "Terjadi kesalahan saat scan";

      state = AsyncError(e, s);

      return null;
    }
  }

  Future<void> inputData(int classId, List<StudentImportModel> students) async {
    ref.read(scanLoadingTextProvider.notifier).state = "Menginput Data...";

    for (final student in students) {
      await _studentService.addStudent(
        name: student.name,
        rollNum: student.rollNum,
        gender: student.gender,
        nis: student.nis,
        nisn: student.nisn,
        classId: classId,
      );
    }

    state = const AsyncData(null);

    ref.invalidate(studentByClass(classId));
  }
}
