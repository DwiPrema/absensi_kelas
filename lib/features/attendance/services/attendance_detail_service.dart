import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/attendance_status_extension.dart';
import 'package:drift/drift.dart';

class AttendanceDetailService {
  final AppDatabase db;
  AttendanceDetailService(this.db);

  Future<List<AttendanceDetail>> getAllAttendanceDetail() async {
    return await db.select(db.attendanceDetails).get();
  }

  // Tambah detail absensi
  Future<int> addAttendanceDetail({
    required int attendanceId,
    required int studentId,
    required StatusKehadiran status,
  }) {
    return db.into(db.attendanceDetails).insert(
      AttendanceDetailsCompanion(
        attendanceId: Value(attendanceId),
        studentId: Value(studentId),
        status: Value(status.value),
      ),
    );
  }

  // Ambil detail absensi + info student
  Future<List<Map<String, dynamic>>> getAttendanceWithStudent(int attendanceId) async {
    final query = db.select(db.attendanceDetails).join([
      innerJoin(db.students, db.students.id.equalsExp(db.attendanceDetails.studentId)),
    ])
      ..where(db.attendanceDetails.attendanceId.equals(attendanceId));

    final results = await query.get();

    return results.map((row) {
      final detail = row.readTable(db.attendanceDetails);
      final student = row.readTable(db.students);
      return {
        'attendanceDetail': detail,
        'student': student,
      };
    }).toList();
  }

  // Hapus detail absensi
  Future<int> deleteAttendanceDetail(int id) {
    return (db.delete(db.attendanceDetails)..where((tbl) => tbl.id.equals(id))).go();
  }
}