import "package:absensi_kelas/core/enums/enum.dart";
import "package:absensi_kelas/core/utils/date_helper.dart";
import "package:isar/isar.dart";

part 'attendance_model.g.dart';

@Collection()
class Attendance {
  Id attendanceId = Isar.autoIncrement;

  @Index()
  late int classId;

  @Index()
  DateTime dateTime = DateHelper.todayOnly();

  late List<AttendanceDetail> details;

  Attendance copyWith({
    int? classId,
    DateTime? dateTime,
    List<AttendanceDetail>? details,
  }) {
    return Attendance()
      ..attendanceId = attendanceId
      ..classId = classId ?? this.classId
      ..dateTime = dateTime ?? this.dateTime
      ..details = details ?? this.details;
  }
}

@embedded
class AttendanceDetail {
  late int studentId;

  @enumerated
  late StatusKehadiran status;
}
