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

class StudentScanNotifier extends AsyncNotifier<void> {
  late final StudentService _studentService;

  @override
  Future<void> build() async {
    _studentService = ref.read(studentServiceProvider);
  }

  Future<String?> pickImageFromCamera() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    return photo!.path;
  }

  Future<String?> pickImageFromGalerry() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    return photo!.path;
  }

  Future<void> scanImage(int classId, String path) async {
    state = const AsyncLoading();
    try {
      ref.read(scanLoadingTextProvider.notifier).state = "Membaca Data...";

      final ocr = OcrService();
      final gemini = GeminiService();

      final textOcr = await ocr.extractText(path);

      ref.read(scanLoadingTextProvider.notifier).state = "Memproses Data...";

      final parseText = await gemini.parseText(textOcr);

      final jsonFormat = jsonDecode(parseText);

      ref.read(scanLoadingTextProvider.notifier).state = "Menginput Data...";

      final students = (jsonFormat as List)
          .map((e) => StudentImportModel.fromJson(e))
          .toList();

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
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}
