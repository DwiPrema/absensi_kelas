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

class StudentScanNotifier extends AsyncNotifier<void> {
  late final StudentService _studentService;

  @override
  Future<void> build() async {
    _studentService = ref.read(studentServiceProvider);
  }

  Future<void> pickAndScanImage(int classId) async {
    state = const AsyncLoading();
    try {
      final picker = ImagePicker();
      final ocr = OcrService();
      final gemini = GeminiService();

      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      print("Start OCR");

      final textOcr = await ocr.extractText(photo!.path);

      print("Finish OCR");

      final parseText = await gemini.parseText(textOcr);

      print("START GEMINI");

      final jsonFormat = jsonDecode(parseText);

      print("GEMINI DONE");

      final students = (jsonFormat as List)
          .map((e) => StudentImportModel.fromJson(e))
          .toList();

      for (final student in students) {
        await _studentService.addStudent(
          name: student.name,
          rollNum: student.rollNum,
          gender: student.gender,
          nis: student.nis,
          nisn: student.nis,
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
