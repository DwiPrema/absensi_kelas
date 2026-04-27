import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:drift/drift.dart';

class StudentService {
  final AppDatabase db;
  StudentService(this.db);

  Future<int> addStudent({
    required String name,
    required String rollNum,
    required String gender,
    String nis = '-',
    String nisn = '-',
    required int classId,
  }) {
    return db.into(db.students).insert(
      StudentsCompanion(
        name: Value(name),
        rollNum: Value(rollNum),
        gender: Value(gender),
        nis: Value(nis),
        nisn: Value(nisn),
        classId: Value(classId),
      ),
    );
  }

  Future<List<Student>> getAllStudents() {
    return db.select(db.students).get();
  }

  Future<List<Student>> getStudentsByClass(int classId) {
    return (db.select(db.students)..where((tbl) => tbl.classId.equals(classId))).get();
  }

  // Update data siswa
  Future<int> updateStudent({
    required int id,
    String? name,
    String? rollNum,
    String? gender,
    String? nis,
    String? nisn,
    int? classId,
  }) {
    final companion = StudentsCompanion(
      name: name != null ? Value(name) : Value.absent(),
      rollNum: rollNum != null ? Value(rollNum) : Value.absent(),
      gender: gender != null ? Value(gender) : Value.absent(),
      nis: nis != null ? Value(nis) : Value.absent(),
      nisn: nisn != null ? Value(nisn) : Value.absent(),
      classId: classId != null ? Value(classId) : Value.absent(),
    );

    return (db.update(db.students)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<void> deleteStudentCascade(int id) async {
    await (db.delete(db.attendanceDetails)..where((tbl) => tbl.studentId.equals(id))).go();

    await (db.delete(db.students)..where((tbl) => tbl.id.equals(id))).go();
  }
}