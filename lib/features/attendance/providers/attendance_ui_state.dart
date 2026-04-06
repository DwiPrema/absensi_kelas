import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:flutter_riverpod/legacy.dart';

final attendanceUIProvider = StateNotifierProvider<
    AttendanceStateUI, Map<int, StatusKehadiran>>(
  (ref) => AttendanceStateUI(),
);

class AttendanceStateUI
    extends StateNotifier<Map<int, StatusKehadiran>> {
  AttendanceStateUI() : super({});

  void updateStatus(int id, StatusKehadiran status) {
    state = {
      ...state,
      id: status,
    };
  }

  void reset() {
  state = {};
}
}