import 'package:absensi_kelas/core/database/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:absensi_kelas/features/students/services/student_service.dart';
import 'package:absensi_kelas/core/database/app_database.dart';

final studentProvider = AsyncNotifierProvider<StudentNotifier, List<Student>>(
  StudentNotifier.new,
);

class StudentNotifier extends AsyncNotifier<List<Student>> {
  late final StudentService service;

  @override
  Future<List<Student>> build() async {
    service = ref.read(studentServiceProvider);
    return service.getAllStudents();
  }

  Future<void> addStudent({
    required String name,
    required String rollNum,
    required int classId,
    String nis = '-',
    String nisn = '-',
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.addStudent(
        name: name,
        rollNum: rollNum,
        classId: classId,
        nis: nis,
        nisn: nisn,
      );
      return service.getAllStudents();
    });
  }

  Future<void> updateStudent({
    required int id,
    String? name,
    String? rollNum,
    String? nis,
    String? nisn,
    int? classId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.updateStudent(
        id: id,
        name: name,
        rollNum: rollNum,
        nis: nis,
        nisn: nisn,
        classId: classId,
      );
      return service.getAllStudents();
    });
  }

  Future<void> deleteStudent(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.deleteStudentCascade(id);
      return service.getAllStudents();
    });
  }

  Future<void> refreshStudents() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => service.getAllStudents());
  }
}

final studentByClass = FutureProvider.family<List<Student>, int>((
  ref,
  classId,
) async {
  final service = ref.read(studentServiceProvider);
  final students = await service.getStudentsByClass(classId);
  return students;
});
