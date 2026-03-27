import 'package:absensi_kelas/features/students/models/student_model.dart';

extension StudentListExtension on List<Student> {
  List<Student> sortByRollNum() {
    final sortedList = [...this];
    sortedList
        .sort((a, b) => int.parse(a.rollNum).compareTo(int.parse(b.rollNum)));

    return sortedList;
  }
}
