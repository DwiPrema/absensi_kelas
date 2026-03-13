import 'package:absensi_kelas/core/database/global_service.dart';
import 'package:absensi_kelas/features/school_classes/models/school_class_model.dart';
import 'package:isar/isar.dart';

class SchoolClassService {
  ///Create school class data
  Future<void> createSchClassData(SchoolClass schoolClass) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.schoolClass.put(schoolClass);
    });
  }

  ///Read school class data
  Future<List<SchoolClass>> getAllSchClassData() async {
    return await DatabaseService.isarDb.schoolClass.where().findAll();
  }

  ///Update school class data
  Future<void> updateSchClassData(SchoolClass schoolClass) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.schoolClass.put(schoolClass);
    });
  }

  ///Delete school class data
  Future<void> deleteSchClassData(int id) async {
    await DatabaseService.isarDb.schoolClass.delete(id);
  }
}
