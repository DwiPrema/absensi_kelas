import 'package:absensi_kelas/core/enums/enum.dart';

extension StatusKehadiranExtension on StatusKehadiran {
  String get value {
    switch (this) {
      case StatusKehadiran.hadir:
        return 'Hadir';
      case StatusKehadiran.alpha:
        return 'Alpha';
      case StatusKehadiran.izin:
        return 'Izin';
      case StatusKehadiran.sakit:
        return 'Sakit';
    }
  }

  static StatusKehadiran fromString(String str) {
    switch (str) {
      case 'Hadir':
        return StatusKehadiran.hadir;
      case 'Alpha':
        return StatusKehadiran.alpha;
      case 'Izin':
        return StatusKehadiran.izin;
      case 'Sakit':
        return StatusKehadiran.sakit;
      default:
        return StatusKehadiran.hadir;
    }
  }
}
