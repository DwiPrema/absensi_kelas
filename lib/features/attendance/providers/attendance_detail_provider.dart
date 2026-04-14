import 'package:absensi_kelas/core/database/provider.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/features/attendance/services/attendance_detail_service.dart';

final attendanceDetailProvider =
    AsyncNotifierProvider<AttendanceDetailNotifier, List<AttendanceDetail>>(
      AttendanceDetailNotifier.new,
    );

class AttendanceDetailNotifier extends AsyncNotifier<List<AttendanceDetail>> {
  late final AttendanceDetailService service;

  @override
  Future<List<AttendanceDetail>> build() async {
    service = ref.read(attendanceDetailServiceProvider);
    return service.getAllAttendanceDetail();
  }

  Future<void> addDetail({
    required int attendanceId,
    required int studentId,
    required StatusKehadiran status,
  }) async {
    await service.addAttendanceDetail(
      attendanceId: attendanceId,
      studentId: studentId,
      status: status,
    );
  }

  Future<void> deleteDetail(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.deleteAttendanceDetail(id);
      return service.getAllAttendanceDetail();
    });
  }
}

final attendanceWithStudentProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((
      ref,
      attendanceId,
    ) async {
      final db = ref.watch(attendanceDetailServiceProvider);

      return await db.getAttendanceWithStudent(attendanceId);
    });
