import "package:absensi_kelas/core/enums/enum.dart";
import 'package:absensi_kelas/features/students/models/student_model.dart';
import "package:isar/isar.dart";

part 'attendance_model.g.dart';

@Collection()
class Attendance {
  Id attendanceId = Isar.autoIncrement;

  @Index()
  final student = IsarLink<Student>();

  @Index()
  late DateTime dateTime;

  @enumerated
  StatusKehadiran statusKehadiran = StatusKehadiran.hadir;
}
