import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:drift/drift.dart';

class SchoolClassService {
  final AppDatabase db;
  SchoolClassService(this.db);

  Future<int> addClass(String name) {
    return db.into(db.schoolClasses).insert(
      SchoolClassesCompanion(name: Value(name)),
    );
  }

  Future<List<SchoolClassesData>> getAllClasses() {
    return db.select(db.schoolClasses).get();
  }

  Future<int> updateClass(int id, String name) {
    return (db.update(db.schoolClasses)..where((tbl) => tbl.id.equals(id)))
        .write(SchoolClassesCompanion(name: Value(name)));
  }

  Future<void> deleteClassCascade(int id) async {
    await (db.delete(db.students)..where((tbl) => tbl.classId.equals(id))).go();

    final attendanceList = await (db.select(db.attendances)..where((tbl) => tbl.classId.equals(id))).get();

    for (var attendance in attendanceList) {
      await (db.delete(db.attendanceDetails)..where((tbl) => tbl.attendanceId.equals(attendance.id))).go();
    }

    await (db.delete(db.attendances)..where((tbl) => tbl.classId.equals(id))).go();

    await (db.delete(db.schoolClasses)..where((tbl) => tbl.id.equals(id))).go();
  }
}