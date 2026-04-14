import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/attendance_status_extension.dart';
import 'package:drift/drift.dart';

class AttendanceService {
  final AppDatabase db;

  AttendanceService(this.db);

  Future<int> addAttendance({
    required int classId,
    required DateTime date,
  }) async {
    return await db
        .into(db.attendances)
        .insert(
          AttendancesCompanion(classId: Value(classId), date: Value(date)),
        );
  }

  Future<int> updateAttendance({
    required int id,
    int? classId,
    DateTime? date,
  }) async {
    return await (db.update(
      db.attendances,
    )..where((t) => t.id.equals(id))).write(
      AttendancesCompanion(
        classId: classId != null ? Value(classId) : Value.absent(),
        date: date != null ? Value(date) : Value.absent(),
      ),
    );
  }

  Future<int> deleteAttendance(int id) async {
    return await (db.delete(
      db.attendances,
    )..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteAttendanceCascade(int id) async {
    await (db.delete(
      db.attendanceDetails,
    )..where((t) => t.attendanceId.equals(id))).go();

    await deleteAttendance(id);
  }

  Future<List<Attendance>> getAllAttendance() async {
    return await db.select(db.attendances).get();
  }

  Future<Attendance?> getAttendanceByClassAndDate({
    required int classId,
    required DateTime date,
  }) async {
    final result = await (db.select(
      db.attendances,
    )..where((t) => t.classId.equals(classId) & t.date.equals(date))).get();

    if (result.isEmpty) return null;

    return result.first;
  }

  Future<List<Attendance>> getAttendanceByClassAndMonth({
    required int classId,
    required DateTime date,
  }) async {
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 1);

    return await (db.select(db.attendances)..where(
          (t) => t.classId.equals(classId) & t.date.isBetweenValues(start, end),
        ))
        .get();
  }

  Future<Map<int, Map<StatusKehadiran, int>>> getMonthlyRecap({
    required List<Attendance> attendances,
    required int month,
    required int year,
  }) async {
    final Map<int, Map<StatusKehadiran, int>> recap = {};

    for (var att in attendances) {
      final details = await (db.select(
        db.attendanceDetails,
      )..where((t) => t.attendanceId.equals(att.id))).get();

      for (var detail in details) {
        final studentId = detail.studentId;

        recap.putIfAbsent(
          studentId,
          () => {
            StatusKehadiran.hadir: 0,
            StatusKehadiran.sakit: 0,
            StatusKehadiran.izin: 0,
            StatusKehadiran.alpha: 0,
          },
        );

        final status = StatusKehadiranExtension.fromString(detail.status);

        recap[studentId]![status] = recap[studentId]![status]! + 1;
      }
    }

    return recap;
  }

  Future<Map<StatusKehadiran, int>> getSumByStatus({
    required int schClassId,
    required DateTime date,
  }) async {
    final attendance =
        await (db.select(db.attendances)..where(
              (attendance) =>
                  attendance.classId.equals(schClassId) &
                  attendance.date.equals(date),
            ))
            .get();

    final result = {
      StatusKehadiran.hadir: 0,
      StatusKehadiran.sakit: 0,
      StatusKehadiran.izin: 0,
      StatusKehadiran.alpha: 0,
    };

    for (var item in attendance) {
      final details = await (db.select(
        db.attendanceDetails,
      )..where((t) => t.attendanceId.equals(item.id))).get();

      for (var detail in details) {
        final status = StatusKehadiranExtension.fromString(detail.status);
        result[status] = result[status]! + 1;
      }
    }

    return result;
  }

  Future<bool> isAlreadyExist(int classId, DateTime date) async {
    final data =
        await (db.select(db.attendances)
              ..where((t) => t.classId.equals(classId) & t.date.equals(date))
              ..limit(1))
            .getSingleOrNull();

    return data != null;
  }
}
