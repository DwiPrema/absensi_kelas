import 'package:absensi_kelas/core/database/app_database.dart';

extension StudentListExtension on List<Student> {
  List<Student> sortByRollNum() {
    final sortedList = [...this];
    sortedList
        .sort((a, b) => int.parse(a.rollNum).compareTo(int.parse(b.rollNum)));

    return sortedList;
  }
}
