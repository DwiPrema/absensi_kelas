import 'package:absensi_kelas/core/database/global_service.dart';
import 'package:absensi_kelas/features/attendance/models/attendance_model.dart';
import 'package:absensi_kelas/features/school_classes/models/school_class_model.dart';
import 'package:absensi_kelas/features/students/models/student_model.dart';
import 'package:isar/isar.dart';

class SchoolClassService {
  ///Create school class data
  Future<void> createSchClassData(SchoolClass schoolClass) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.schoolClass.put(schoolClass);
      await schoolClass.students.save();
    });
  }

  ///Read school class data
  Future<List<SchoolClass>> getAllSchClassData() async {
    final classes = await DatabaseService.isarDb.schoolClass.where().findAll();

    for (var c in classes) {
      await c.students.load();
    }

    return classes;
  }

  ///Update school class data
  Future<void> updateSchClassData(SchoolClass schoolClass) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.schoolClass.put(schoolClass);
      await schoolClass.students.save();
    });
  }

  ///Delete school class data
  Future<void> deleteSchClassDataWithRelation(int id) async {
    final isar = DatabaseService.isarDb;
    await isar.writeTxn(() async {
      await isar.attendances.filter().classIdEqualTo(id).deleteAll();

      final schoolClass = await isar.schoolClass.get(id);
      if (schoolClass == null) return;

      await schoolClass.students.load();

      final studentIds = schoolClass.students.map((e) => e.studentId).toList();
      await isar.students.deleteAll(studentIds);

      await isar.schoolClass.delete(id);
    });
  }
}
