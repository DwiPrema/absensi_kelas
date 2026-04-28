import 'dart:io';

class ExportFileModel {
  final File file;
  final String name;
  final String size;
  final DateTime modified;

  ExportFileModel({
    required this.file,
    required this.name,
    required this.size,
    required this.modified,
  });
}