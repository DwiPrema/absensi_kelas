import 'package:absensi_kelas/core/database/provider.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/features/attendance/services/attendance_service.dart';

final attendanceProvider =
    AsyncNotifierProvider<AttendanceNotifier, List<Attendance>>(
      AttendanceNotifier.new,
    );

class AttendanceNotifier extends AsyncNotifier<List<Attendance>> {
  late final AttendanceService service;

  @override
  Future<List<Attendance>> build() async {
    service = ref.read(attendanceServiceProvider);
    return service.getAllAttendance();
  }

  Future<int> createAttendance({
    required int classId,
    required DateTime date,
  }) async {
    return await service.addAttendance(classId: classId, date: date);
  }

  Future<void> fetchAttendance({
    required int classId,
    required DateTime date,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.addAttendance(classId: classId, date: date);
      return service.getAllAttendance();
    });
  }

  Future<void> updateAttendance({
    required int id,
    int? classId,
    DateTime? date,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.updateAttendance(id: id, classId: classId, date: date);
      return service.getAllAttendance();
    });
  }

  Future<void> deleteAttendance(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.deleteAttendanceCascade(id);
      return service.getAllAttendance();
    });
  }
}

final attendanceByClassAndMonthProvider =
    FutureProvider.family<List<Attendance>, (int, DateTime)>((
      ref,
      param,
    ) async {
      final service = ref.watch(attendanceServiceProvider);
      return service.getAttendanceByClassAndMonth(
        classId: param.$1,
        date: param.$2,
      );
    });

final attendanceMonthlyRecapProvider =
    FutureProvider.family<
      Map<String, Map<StatusKehadiran, int>>,
      (int, DateTime)
    >((ref, param) async {
      final service = ref.watch(attendanceServiceProvider);
      final date = param.$2;

      final data = await service.getAttendanceByClassAndMonth(
        classId: param.$1,
        date: date,
      );

      return service.getMonthlyRecap(
        attendances: data,
        month: date.month,
        year: date.year,
      );
    });

final summaryProvider = FutureProvider.family((
  ref,
  (int schClassId, DateTime date) param,
) async {
  final service = ref.watch(attendanceServiceProvider);

  return service.getSumByStatus(schClassId: param.$1, date: param.$2);
});

final attendanceByClassAndDateProvider =
    FutureProvider.family<Attendance?, (int, DateTime)>((ref, param) async {
      final service = ref.watch(attendanceServiceProvider);

      return service.getAttendanceByClassAndDate(
        classId: param.$1,
        date: param.$2,
      );
    });
