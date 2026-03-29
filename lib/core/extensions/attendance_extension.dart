import 'package:absensi_kelas/features/attendance/models/attendance_model.dart';

extension AttendanceListExtension on List<Attendance> {
  List<Attendance> sortDateTimeDes() {
    final sortedList = [...this];
    sortedList.sort((a, b) => (b.dateTime).compareTo(a.dateTime));

    return sortedList;
  }
}
