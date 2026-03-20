import 'package:absensi_kelas/features/attendance/models/attendance_model.dart';
import 'package:absensi_kelas/features/attendance/services/attendance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final attendanceProvider =
    AsyncNotifierProvider<AttendanceNotifier, List<Attendance>>(AttendanceNotifier.new);

class AttendanceNotifier extends AsyncNotifier<List<Attendance>> {
  final service = AttendanceService();

  @override
  Future<List<Attendance>> build() async {
    return service.getAllAttenData();
  }

  Future<void> createData(Attendance attendance) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.createAttenData(attendance);
      return service.getAllAttenData();
    });
  }

  Future<void> deleteData(int id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.deleteAttenData(id);
      return service.getAllAttenData();
    });
  }

  Future<void> updateData(Attendance attendance) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.updateAttenData(attendance);
      return service.getAllAttenData();
    });
  }
}
