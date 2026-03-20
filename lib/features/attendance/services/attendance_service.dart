import 'package:absensi_kelas/core/database/global_service.dart';
import 'package:absensi_kelas/features/attendance/models/attendance_model.dart';
import 'package:isar/isar.dart';

class AttendanceService {
  ///Create Attendance data
  Future<void> createAttenData(Attendance attendance) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.attendances.put(attendance);
      await attendance.student.save();
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
      await attendance.student.save();
    });
  }

  ///Delete Attendance Data
  Future<void> deleteAttenData(int id) async {
    await DatabaseService.isarDb.writeTxn(() async {
      await DatabaseService.isarDb.attendances.delete(id);
    });
  }
}
