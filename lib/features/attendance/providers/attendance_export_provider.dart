import 'dart:io';

import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/student_extension.dart';
import 'package:absensi_kelas/core/utils/file_size.dart';
import 'package:absensi_kelas/features/attendance/models/export_file_model.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as p;

final attendanceExportProvider =
    AsyncNotifierProvider<AttendanceExportProvider, List<ExportFileModel>>(
      AttendanceExportProvider.new,
    );

class AttendanceExportProvider extends AsyncNotifier<List<ExportFileModel>> {
  @override
  Future<List<ExportFileModel>> build() async {
    return loadFiles();
  }

  Future<List<ExportFileModel>> loadFiles() async {
    final dir =
        await getDownloadsDirectory() ?? await getApplicationSupportDirectory();

    final files = dir
        .listSync()
        .whereType<File>()
        .where((e) => e.path.endsWith('.xlsx'))
        .toList();

    files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

    return await Future.wait(
      files.map((file) async {
        return ExportFileModel(
          file: file,
          name: basename(file.path),
          size: await getSize(file),
          modified: await file.lastModified(),
        );
      }),
    );
  }

  Future<void> deleteFile(File file) async {
    if (await file.exists()) {
      await file.delete();
      refreshData();
    }
  }

  Future<void> openFile(File file, BuildContext context) async {
    final result = await OpenFilex.open(file.path);
    if (!context.mounted) return;

    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File tidak bisa dibuka: ${result.message}')),
      );
    }
  }

  Future<void> shareFile(File file) async {
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = AsyncData(await loadFiles());
  }

  String _safeFileName(String input) {
    return input.trim().replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  Future<File> _exportMonthlyRecapToExcel(
    List<Student> students,
    Map<int, Map<StatusKehadiran, int>> recap,
    String className,
    String month,
  ) async {
    final excel = Excel.createExcel();
    const sheetName = 'Rekap';
    final sheet = excel[sheetName];

    if (excel.sheets.keys.length > 1 && excel.sheets.keys.contains('Sheet1')) {
      excel.delete('Sheet1');
    }

    sheet.appendRow([
      TextCellValue('No Absen'),
      TextCellValue('Nama'),
      TextCellValue('Jenis Kelamin'),
      TextCellValue('Hadir'),
      TextCellValue('Izin'),
      TextCellValue('Sakit'),
      TextCellValue('Alpha'),
    ]);

    final sortedStudent = students.sortByRollNum();
    for (var i = 0; i < sortedStudent.length; i++) {
      final student = sortedStudent[i];
      final data =
          recap[student.id] ??
          {
            StatusKehadiran.hadir: 0,
            StatusKehadiran.sakit: 0,
            StatusKehadiran.izin: 0,
            StatusKehadiran.alpha: 0,
          };

      final hadir = data[StatusKehadiran.hadir] ?? 0;
      final izin = data[StatusKehadiran.izin] ?? 0;
      final sakit = data[StatusKehadiran.sakit] ?? 0;
      final alpha = data[StatusKehadiran.alpha] ?? 0;

      sheet.appendRow([
        TextCellValue(student.rollNum),
        TextCellValue(student.name),
        TextCellValue(student.gender),
        IntCellValue(hadir),
        IntCellValue(izin),
        IntCellValue(sakit),
        IntCellValue(alpha),
      ]);
    }

    final bytes = excel.save();
    if (bytes == null) {
      throw Exception('Gagal membuat file Excel');
    }

    final downloadsDir =
        await getDownloadsDirectory() ?? await getApplicationSupportDirectory();

    final fileName = _safeFileName(
      'rekap_absen_${className}_${month}_${DateTime.now().millisecondsSinceEpoch}.xlsx',
    );
    final file = File(p.join(downloadsDir.path, fileName));
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> handleExport(
    BuildContext context,
    WidgetRef ref,
    List<Student> students,
    Map<int, Map<StatusKehadiran, int>> recap,
    String className,
    String month,
  ) async {
    try {
      final file = await _exportMonthlyRecapToExcel(
        students,
        recap,
        className,
        month,
      );
      await ref.read(attendanceExportProvider.notifier).refreshData();
      if (!context.mounted) return;

      showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.background,
          title: textPoppins(
            "Berhasil",
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          content: textPoppins(
            "Excel tersimpan di : \n ${file.path}",
            color: AppColors.black,
          ),
          actions: [
            Button(
              text: "Tutup",
              textColor: AppColors.black,
              bgColor: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              borderRadius: BorderRadius.circular(10),
              onPressed: () => Navigator.pop(context),
            ),
            Button(
              text: "Buka",
              textColor: AppColors.white,
              bgColor: AppColors.blueCard,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              borderRadius: BorderRadius.circular(10),
              onPressed: () async {
                Navigator.pop(context);

                final result = await OpenFilex.open(file.path);
                if (!context.mounted) return;

                if (result.type != ResultType.done) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'File tidak bisa dibuka: ${result.message}',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal export Excel: $e')));
    }
  }
}
