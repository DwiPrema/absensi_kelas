import "package:absensi_kelas/features/students/models/student_model.dart";
import "package:isar/isar.dart";

part 'school_class_model.g.dart';

@Collection()
class SchoolClass {
  Id schoolClassId = Isar.autoIncrement;

  @Index()
  late String schClassName;

  final students = IsarLinks<Student>();

  SchoolClass copyWith({
    String? schClassName,
  }) {
    return SchoolClass()
      ..schoolClassId = schoolClassId
      ..schClassName = schClassName ?? this.schClassName;
  }
}
