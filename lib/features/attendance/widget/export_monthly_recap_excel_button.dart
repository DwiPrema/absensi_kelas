import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_export_provider.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExportMonthlyRecapExcelButton extends ConsumerWidget {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(attendanceExportProvider.notifier);

    return Button(
      text: "Export Excel",
      textColor: mainColor,
      bgColor: AppColors.white,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      borderRadius: BorderRadius.circular(10),
      onPressed: () => notifier.handleExport(
        context,
        ref,
        students,
        recap,
        className,
        month,
      ),
    );
  }
}
