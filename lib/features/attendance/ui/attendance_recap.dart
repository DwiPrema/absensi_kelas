import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/student_extension.dart';
import 'package:absensi_kelas/features/attendance/widget/export_monthly_recap_excel_button.dart';
import 'package:absensi_kelas/features/attendance/widget/attendance_main_card.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MonthlyStudentRecap extends StatelessWidget {
  final Map<int, Map<StatusKehadiran, int>> recap;
  final List<Student> students;
  final String className;
  final String month;
  final Color mainColor;

  const MonthlyStudentRecap({
    super.key,
    required this.recap,
    required this.students,
    required this.className,
    required this.month,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final sortedStudent = students.sortByRollNum();

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: mainColor,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      color: AppColors.black.withAlpha(50),
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.all(16),
                title: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      textPoppins(
                        className,
                        color: AppColors.white,
                        fontSize: 14,
                        textAlign: TextAlign.right,
                      ),
                      textPoppins(month,
                          color: AppColors.white,
                          fontSize: 8,
                          textAlign: TextAlign.right),
                    ],
                  ),
                ),
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            mainColor,
                            mainColor.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 16),
                      alignment: Alignment.topCenter,
                      child: textPagratiNarrow(
                        "Data Rekap Absen",
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
        
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ExportMonthlyRecapExcelButton(recap: recap, students: students, className: className, month: month, mainColor: mainColor)),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final student = sortedStudent[index];
                    final data = recap[student.id] ??
                        {
                          StatusKehadiran.hadir: 0,
                          StatusKehadiran.sakit: 0,
                          StatusKehadiran.izin: 0,
                          StatusKehadiran.alpha: 0,
                        };
        
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: AttendanceMainCard(
                        studentName: student.name,
                        rollNum: student.rollNum,
                        hadir: data[StatusKehadiran.hadir].toString(),
                        izin: data[StatusKehadiran.izin].toString(),
                        sakit: data[StatusKehadiran.sakit].toString(),
                        alpha: data[StatusKehadiran.alpha].toString(),
                        mainColor: mainColor,
                      ),
                    );
                  },
                  childCount: sortedStudent.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
