import 'package:absensi_kelas/features/students/models/student_model.dart';
import 'package:absensi_kelas/features/students/services/student_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schClassProvider =
    AsyncNotifierProvider<StudentNotifier, List<Student>>(StudentNotifier.new);

class StudentNotifier extends AsyncNotifier<List<Student>> {
  final service = StudentService();

  @override
  Future<List<Student>> build() async {
    return service.getAllStudentData();
  }

  Future<void> createData(Student student) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.createStudentData(student);
      return service.getAllStudentData();
    });
  }

  Future<void> deleteData(int id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.deleteStudentData(id);
      return service.getAllStudentData();
    });
  }

  Future<void> updateData(Student student) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.updateStudentData(student);
      return service.getAllStudentData();
    });
  }
}
