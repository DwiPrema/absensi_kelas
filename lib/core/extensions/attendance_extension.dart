import 'package:absensi_kelas/core/database/app_database.dart';

extension AttendanceListExtension on List<Attendance> {
  List<Attendance> sortDateTimeDes() {
    final sortedList = [...this];
    sortedList.sort((a, b) => (b.date).compareTo(a.date));

    return sortedList;
  }
}
