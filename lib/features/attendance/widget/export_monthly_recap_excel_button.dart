import 'dart:io';

import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/student_extension.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ExportMonthlyRecapExcelButton extends StatelessWidget {
  final Map<int, Map<StatusKehadiran, int>> recap;
  final List<Student> students;
  final String className;
  final String month;
  final Color mainColor;

  const ExportMonthlyRecapExcelButton({
    super.key,
    required this.recap,
    required this.students,
    required this.className,
    required this.month,
    required this.mainColor,
  });

  String _safeFileName(String input) {
    return input.trim().replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  Future<File> _exportMonthlyRecapToExcel() async {
    final excel = Excel.createExcel();
    const sheetName = 'Rekap';
    final sheet = excel[sheetName];

    if (excel.sheets.keys.length > 1 && excel.sheets.keys.contains('Sheet1')) {
      excel.delete('Sheet1');
    }

    sheet.appendRow([
      TextCellValue('No Absen'),
      TextCellValue('Nama'),
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

  Future<void> _handleExport(BuildContext context) async {
    try {
      final file = await _exportMonthlyRecapToExcel();
      if (!context.mounted) return;

      showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.background,
          title: textPoppins("Berhasil", fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.black),
          content: textPoppins("Excel tersimpan di : \n ${file.path}", color: AppColors.black),
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

  @override
  Widget build(BuildContext context) {
    return Button(
      text: "Export Excel",
      textColor: mainColor,
      bgColor: AppColors.white,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      borderRadius: BorderRadius.circular(10),
      onPressed: () => _handleExport(context),
    );
  }
}
