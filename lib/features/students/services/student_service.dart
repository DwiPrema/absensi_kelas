import 'package:absensi_kelas/core/database/global_service.dart';
import 'package:absensi_kelas/features/students/models/student_model.dart';
import 'package:isar/isar.dart';

class StudentService {
  ///Create student data
  Future<void> createStudentData(Student student) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.students.put(student);
      await student.schClass.save();
    });
  }

  ///Read student data
  Future<List<Student>> getAllStudentData() async {
    return await DatabaseService.isarDb.students.where().findAll();
  }

  ///Update student data
  Future<void> updateStudentData(Student student) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.students.put(student);
      await student.schClass.save();
    });
  }

  ///Delete student data
  Future<void> deleteStudentData(int id) async {
    await DatabaseService.isarDb.students.delete(id);
  }
}