import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:drift/drift.dart';

class StudentService {
  final AppDatabase db;
  StudentService(this.db);

  // Tambah siswa baru
  Future<int> addStudent({
    required String name,
    required String rollNum,
    String nis = '-',
    String nisn = '-',
    required int classId,
  }) {
    return db.into(db.students).insert(
      StudentsCompanion(
        name: Value(name),
        rollNum: Value(rollNum),
        nis: Value(nis),
        nisn: Value(nisn),
        classId: Value(classId),
      ),
    );
  }

  // Ambil semua siswa
  Future<List<Student>> getAllStudents() {
    return db.select(db.students).get();
  }

  // Ambil siswa berdasarkan kelas
  Future<List<Student>> getStudentsByClass(int classId) {
    return (db.select(db.students)..where((tbl) => tbl.classId.equals(classId))).get();
  }

  // Update data siswa
  Future<int> updateStudent({
    required int id,
    String? name,
    String? rollNum,
    String? nis,
    String? nisn,
    int? classId,
  }) {
    final companion = StudentsCompanion(
      name: name != null ? Value(name) : Value.absent(),
      rollNum: rollNum != null ? Value(rollNum) : Value.absent(),
      nis: nis != null ? Value(nis) : Value.absent(),
      nisn: nisn != null ? Value(nisn) : Value.absent(),
      classId: classId != null ? Value(classId) : Value.absent(),
    );

    return (db.update(db.students)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  // Hapus siswa + cascade hapus detail absensi
  Future<void> deleteStudentCascade(int id) async {
    // Hapus semua detail absensi milik siswa ini
    await (db.delete(db.attendanceDetails)..where((tbl) => tbl.studentId.equals(id))).go();

    // Hapus siswa
    await (db.delete(db.students)..where((tbl) => tbl.id.equals(id))).go();
  }
}