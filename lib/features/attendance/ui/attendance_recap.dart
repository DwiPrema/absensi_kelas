import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/student_extension.dart';
import 'package:absensi_kelas/features/students/models/student_model.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MonthlyStudentRecap extends StatelessWidget {
  final Map<String, Map<StatusKehadiran, int>> recap;
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
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   expandedHeight: 160,
          //   pinned: true,
          //   backgroundColor: mainColor,
          //   flexibleSpace: FlexibleSpaceBar(
          //     centerTitle: false,
          //     titlePadding: const EdgeInsets.all(16),
          //     title: Padding(
          //       padding: const EdgeInsets.only(left: 16, bottom: 50),
          //       child: Align(
          //         alignment: Alignment.bottomRight,
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               className,
          //               style: const TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             Text(
          //               month,
          //               style: const TextStyle(
          //                 fontSize: 14,
          //                 color: Colors.white70,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     background: Align(
          //       alignment: Alignment.bottomRight,
          //       child: textPagratiNarrow("Rekap Absen",
          //           color: AppColors.white, fontSize: 24),
          //     ),
          //   ),
          // ),

          SliverAppBar(
            expandedHeight: 120,
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
                          mainColor.withOpacity(0.7),
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
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final student = sortedStudent[index];
                  final data = recap[student.studentId.toString()] ??
                      {
                        StatusKehadiran.hadir: 0,
                        StatusKehadiran.sakit: 0,
                        StatusKehadiran.izin: 0,
                        StatusKehadiran.alpha: 0,
                      };

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        student.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _StatusItem(
                              label: "Hadir",
                              total: data[StatusKehadiran.hadir]!.toString(),
                              color: AppColors.greenHadir,
                            ),
                            _StatusItem(
                              label: "Izin",
                              total: data[StatusKehadiran.izin]!.toString(),
                              color: AppColors.blueIzin,
                            ),
                            _StatusItem(
                              label: "Sakit",
                              total: data[StatusKehadiran.sakit]!.toString(),
                              color: AppColors.yellow,
                            ),
                            _StatusItem(
                              label: "Alpha",
                              total: data[StatusKehadiran.alpha]!.toString(),
                              color: AppColors.redAlpha,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: sortedStudent.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final String total;
  final Color color;

  const _StatusItem({
    required this.label,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          total,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
