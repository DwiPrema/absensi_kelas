import "package:isar/isar.dart";

part 'school_class_model.g.dart';

@Collection()
class SchoolClass {
  Id schoolClassId = Isar.autoIncrement;

  late String schClassName;
}
