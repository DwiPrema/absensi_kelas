import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/features/school_classes/services/school_class_service.dart';
import 'package:absensi_kelas/features/students/services/student_service.dart';
import 'package:absensi_kelas/features/attendance/services/attendance_service.dart';
import 'package:absensi_kelas/features/attendance/services/attendance_detail_service.dart';

// Database
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Services
final schoolClassServiceProvider = Provider<SchoolClassService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SchoolClassService(db);
});

final studentServiceProvider = Provider<StudentService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return StudentService(db);
});

final attendanceServiceProvider = Provider<AttendanceService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AttendanceService(db);
});

final attendanceDetailServiceProvider = Provider<AttendanceDetailService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AttendanceDetailService(db);
});