import 'package:absensi_kelas/features/attendance/models/attendance_model.dart';
import 'package:absensi_kelas/features/school_classes/models/school_class_model.dart';
import 'package:absensi_kelas/features/students/models/student_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static late final Isar isarDb;

  static Future<void> setup() async {
    final appDir = await getApplicationDocumentsDirectory();

    isarDb = await Isar.open([
      SchoolClassSchema,
      AttendanceSchema,
      StudentSchema,
    ], directory: appDir.path);
  }
}
