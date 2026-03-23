import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/utils/date_helper.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_provider.dart';
import 'package:absensi_kelas/features/attendance/widget/box_absen.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ResultAttendancePage extends ConsumerWidget {
  final int schoolClassId;
  final String schoolClassName;
  final String totalStudent;
  const ResultAttendancePage(
      {super.key,
      required this.schoolClassId,
      required this.schoolClassName,
      required this.totalStudent});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //date
    final dateNow = DateHelper.todayOnly();
    final locale = Localizations.localeOf(context).toString();
    final String day = DateFormat('EEEE', locale).format(dateNow);
    final String date = DateFormat('dd MMMM yyyy', locale).format(dateNow);

    final summaryStatusState =
        ref.watch(summaryProvider((schoolClassId, dateNow)));

    final attendanceState =
        ref.watch(attendanceByClassAndDateProvider((schoolClassId, dateNow)));

    final studentState = ref.watch(studentProviders(schoolClassId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),

              textPagratiNarrow("Hasil Absensi",
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// DATE CARD
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 6,
                                offset: Offset(0, 3),
                                color: Colors.black12,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              textPoppins("$day,",
                                  color: AppColors.yellow,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              textPoppins(date,
                                  color: AppColors.yellow,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      /// RIGHT SIDE
                      Expanded(
                        child: Column(
                          children: [
                            _infoBox("Kelas", schoolClassName),
                            const SizedBox(height: 10),
                            _infoBox("Total", totalStudent),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              summaryStatusState.when(
                  data: (data) {
                    final hadir = data[StatusKehadiran.hadir] ?? 0;
                    final izin = data[StatusKehadiran.izin] ?? 0;
                    final sakit = data[StatusKehadiran.sakit] ?? 0;
                    final alpha = data[StatusKehadiran.alpha] ?? 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          _statusBox(
                            "Hadir",
                            hadir.toString(),
                            AppColors.greenHadir,
                          ),
                          _statusBox(
                            "Izin",
                            izin.toString(),
                            AppColors.blueIzin,
                          ),
                          _statusBox(
                            "Sakit",
                            sakit.toString(),
                            AppColors.yellow,
                          ),
                          _statusBox(
                            "Alpha",
                            alpha.toString(),
                            AppColors.redAlpha,
                          ),
                        ],
                      ),
                    );
                  },
                  error: (e, s) => textPoppins(
                      "Maaf, jumlah status saat ini belum bisa ditampilkan"),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      )),

              const SizedBox(height: 16),

              /// LIST SISWA
              attendanceState.when(
                data: (attendance) {
                  final attendanceMap = {
                    for (var detail in attendance?.details ?? [])
                      detail.studentId: detail.status
                  };

                  return studentState.when(
                    data: (studentList) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                          final student = studentList[index];

                          final status = attendanceMap[student.studentId] ??
                              StatusKehadiran.alpha;

                          return BoxAbsen(
                            nama: student.name,
                            no: student.rollNum,
                            mainColor: AppColors.black,
                            nis: student.nis,
                            nisn: student.nisn,
                            status: status,
                            isResultPage: true,
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (e, s) =>
                        textPoppins("Error Siswa", color: AppColors.black),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (e, s) =>
                    textPoppins("Error absensi", color: AppColors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textPoppins(title,
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textPoppins(value,
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }

  /// STATUS BOX
  static Widget _statusBox(String title, String value, Color color) {
    return Expanded(
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textPoppins(title,
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            textPoppins(value,
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }
}
