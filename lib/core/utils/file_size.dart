import 'dart:io';

Future<String> getSize(File file) async {
  final bytes = await file.length();

  if (bytes < 1024) {
    return "$bytes B";
  } else if (bytes < 1024 * 1024) {
    return "${(bytes / 1024).toStringAsFixed(1)} KB";
  } else {
    return "${(bytes / 1024 / 1024).toStringAsFixed(1)} MB";
  }
}