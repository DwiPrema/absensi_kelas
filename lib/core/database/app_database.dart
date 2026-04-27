import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// ============================
/// TABEL SCHOOL CLASS
/// ============================
class SchoolClasses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

/// ============================
/// TABEL STUDENT
/// ============================
class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get rollNum => text()();
  TextColumn get nis => text().withDefault(const Constant('-'))();
  TextColumn get nisn => text().withDefault(const Constant('-'))();
  TextColumn get gender => text()();
  IntColumn get classId => integer()(); // relasi ke SchoolClass
}

/// ============================
/// TABEL ATTENDANCE
/// ============================
class Attendances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get classId => integer()(); // relasi ke SchoolClass
  DateTimeColumn get date => dateTime()();
}

/// ============================
/// TABEL ATTENDANCE DETAIL
/// ============================
class AttendanceDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get attendanceId => integer()(); // relasi ke Attendance
  IntColumn get studentId => integer()(); // relasi ke Student
  TextColumn get status => text()();
}

/// ============================
/// DATABASE
/// ============================
@DriftDatabase(
  tables: [SchoolClasses, Students, Attendances, AttendanceDetails],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'absensi_db.sqlite'));
    return NativeDatabase(file);
  });
}
