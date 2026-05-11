import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';

extension StudentListExtension on List<Student> {
  List<Student> sortByRollNum() {
    final sortedList = [...this];
    sortedList.sort(
      (a, b) =>
          int.parse(a.rollNum.trim()).compareTo(int.parse(b.rollNum.trim())),
    );

    return sortedList;
  }
}

extension GenderExtension on Gender {
  String get value {
    switch (this) {
      case Gender.l:
        return 'Laki-laki';
      case Gender.p:
        return 'Perempuan';
    }
  }
}

extension GenderStringExtension on String {
  Gender toGender() {
    switch (toLowerCase()) {
      case 'l':
      case 'laki-laki':
        return Gender.l;

      case 'p':
      case 'perempuan':
        return Gender.p;

      default:
        return Gender.l;
    }
  }
}
