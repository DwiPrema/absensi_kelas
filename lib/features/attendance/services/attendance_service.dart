import 'package:absensi_kelas/core/database/global_service.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/features/attendance/models/attendance_model.dart';
import 'package:isar/isar.dart';

class AttendanceService {
  ///Create Attendance data
  Future<void> createAttenData(Attendance attendance) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.attendances.put(attendance);
    });
  }

  ///Read Attendance Data
  Future<List<Attendance>> getAllAttenData() async {
    return await DatabaseService.isarDb.attendances.where().findAll();
  }

  ///Update Attendance Data
  Future<void> updateAttenData(Attendance attendance) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.attendances.put(attendance);
    });
  }

  ///Delete Attendance Data
  Future<void> deleteAttenData(int id) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.attendances.delete(id);
    });
  }

  Future<Map<StatusKehadiran, int>> getSumByStatus({
    required int schClassId,
    required DateTime date,
  }) async {
    final attendance = await DatabaseService.isarDb.attendances
        .filter()
        .classIdEqualTo(schClassId)
        .and()
        .dateTimeEqualTo(date)
        .findFirst();

    if (attendance == null) {
      return {
        StatusKehadiran.hadir: 0,
        StatusKehadiran.sakit: 0,
        StatusKehadiran.izin: 0,
        StatusKehadiran.alpha: 0,
      };
    }

    final result = {
      StatusKehadiran.hadir: 0,
      StatusKehadiran.sakit: 0,
      StatusKehadiran.izin: 0,
      StatusKehadiran.alpha: 0,
    };

    for (var item in attendance.details) {
      result[item.status] = result[item.status]! + 1;
    }

    return result;
  }

  Future<bool> isAlreadyExist(int classId, DateTime date) async {
    final data = await DatabaseService.isarDb.attendances
        .filter()
        .classIdEqualTo(classId)
        .and()
        .dateTimeEqualTo(date)
        .findFirst();

    return data != null;
  }

  Future<Attendance?> getAttendanceByClassAndDate({
    required int classId,
    required DateTime date,
  }) async {
    return await DatabaseService.isarDb.attendances
        .filter()
        .classIdEqualTo(classId)
        .dateTimeEqualTo(date)
        .findFirst();
  }

  Future<List<Attendance>> getAttendanceByClass({
    required int classId,
  }) async {
    return await DatabaseService.isarDb.attendances
        .filter()
        .classIdEqualTo(classId)
        .findAll();
  }

  Future<List<Attendance>> getAttendanceByClassAndMonth({
    required int classId,
    required DateTime date,
  }) async {
    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 1);

    return await DatabaseService.isarDb.attendances
        .filter()
        .classIdEqualTo(classId)
        .and()
        .dateTimeGreaterThan(start, include: true)
        .and()
        .dateTimeLessThan(end, include: false)
        .findAll();
  }

  Map<String, Map<StatusKehadiran, int>> getMonthlyRecap({
    required List<Attendance> attendances,
    required int month,
    required int year,
  }) {
    final Map<String, Map<StatusKehadiran, int>> recap = {};
    final filtered = attendances
        .where((e) => e.dateTime.month == month && e.dateTime.year == year);

    for (var attendance in filtered) {
      for (var detail in attendance.details) {
        final id = detail.studentId.toString();

        if (!recap.containsKey(id)) {
          recap[id] = {
            StatusKehadiran.hadir: 0,
            StatusKehadiran.izin: 0,
            StatusKehadiran.sakit: 0,
            StatusKehadiran.alpha: 0,
          };
        }

        switch (detail.status) {
          case StatusKehadiran.hadir:
            recap[id]![StatusKehadiran.hadir] =
                recap[id]![StatusKehadiran.hadir]! + 1;
            break;
          case StatusKehadiran.sakit:
            recap[id]![StatusKehadiran.sakit] =
                recap[id]![StatusKehadiran.sakit]! + 1;
            break;
          case StatusKehadiran.izin:
            recap[id]![StatusKehadiran.izin] =
                recap[id]![StatusKehadiran.izin]! + 1;
            break;
          case StatusKehadiran.alpha:
            recap[id]![StatusKehadiran.alpha] =
                recap[id]![StatusKehadiran.alpha]! + 1;
            break;
        }
      }
    }

    return recap;
  }
}
