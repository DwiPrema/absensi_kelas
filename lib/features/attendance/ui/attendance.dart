import 'package:absensi_kelas/features/attendance/widget/box_absen.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Attendance extends ConsumerStatefulWidget {
  final Color headerColor;
  final Color gradientHeaderColor;
  final int schoolClassId;
  final String schoolClassName;

  const Attendance({
    super.key,
    required this.headerColor,
    required this.gradientHeaderColor,
    required this.schoolClassId,
    required this.schoolClassName,
  });

  @override
  ConsumerState<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends ConsumerState<Attendance> {
  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProviders(widget.schoolClassId));

    final dateNow = DateTime.now();

    final locale = Localizations.localeOf(context).toString();

    final String day = DateFormat('EEEE', locale).format(dateNow);
    final String date = DateFormat('dd MMM', locale).format(dateNow);

    final students = studentState.value ?? [];
    final totalStudents = students.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.headerColor,
                                widget.gradientHeaderColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: textPagratiNarrow(
                              widget.schoolClassName,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 80,
                              margin: const EdgeInsets.only(top: 110),
                              decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textPagratiNarrow(
                                    "Jumlah",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                  textPagratiNarrow(
                                    "$totalStudents",
                                    color: AppColors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 100,
                              height: 80,
                              margin: const EdgeInsets.only(top: 110),
                              decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textPagratiNarrow(
                                    day,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                  textPagratiNarrow(
                                    date,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// LIST SISWA
                    studentState.when(
                      data: (studentList) {
                        if (studentList.isEmpty) {
                          return Center(
                            child: textPoppins(
                              "Belum ada data siswa",
                              color: AppColors.black,
                            ),
                          );
                        }

                        final sortedList = [...studentList];

                        sortedList.sort((a, b) => int.parse(a.rollNum)
                            .compareTo(int.parse(b.rollNum)));

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sortedList.length,
                          itemBuilder: (context, index) {
                            final student = sortedList[index];

                            return BoxAbsen(
                              nama: student.name,
                              no: student.rollNum.toString(),
                              nis: student.nis,
                              nisn: student.nisn,
                            );
                          },
                        );
                      },
                      error: (error, stack) => Center(
                        child: textPoppins("Terjadi kesalahan: $error"),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),

            /// BUTTON
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: widget.headerColor,
                  ),
                  onPressed: () {},
                  child: textPoppins(
                    "Kirim",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
