import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/attendance_status_extension.dart';
import 'package:absensi_kelas/core/utils/date_helper.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_detail_provider.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_provider.dart';
import 'package:absensi_kelas/features/attendance/widget/box_absen.dart';
import 'package:absensi_kelas/widgets/box.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ResultAttendancePage extends ConsumerWidget {
  final int schoolClassId;
  final String schoolClassName;
  final String totalStudent;
  final DateTime? dateTime;
  final int attendanceId;

  const ResultAttendancePage({
    super.key,
    required this.schoolClassId,
    required this.schoolClassName,
    required this.totalStudent,
    required this.attendanceId,
    this.dateTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateNow = dateTime ?? DateHelper.todayOnly();
    final locale = Localizations.localeOf(context).toString();
    final String day = DateFormat('EEEE', locale).format(dateNow);
    final String date = DateFormat('dd MMMM yyyy', locale).format(dateNow);

    final summaryStatusState = ref.watch(
      summaryProvider((schoolClassId, dateNow)),
    );

    final attendanceDetail = ref.watch(
      attendanceWithStudentProvider(attendanceId),
    );

    final paddingTopSafeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              collapsedHeight: 300,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.background,
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
              flexibleSpace: Column(
                children: [
                  SizedBox(height: paddingTopSafeArea + 16),
                  textPagratiNarrow(
                    "Hasil Absensi",
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textPoppins(
                                    "$day,",
                                    color: AppColors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textPoppins(
                                    date,
                                    color: AppColors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                BoxInfo(
                                  label: "Kelas",
                                  value: schoolClassName,
                                  color: AppColors.yellow,
                                ),
                                const SizedBox(height: 10),
                                attendanceDetail.when(
                                  data: (studentList) {
                                    final totalStudent = studentList.length;

                                    return BoxInfo(
                                      label: "Total",
                                      value: totalStudent.toString(),
                                      color: AppColors.yellow,
                                    );
                                  },
                                  error: (e, s) => const BoxInfo(
                                    label: "Jumlah Siswa",
                                    value: "0",
                                    color: AppColors.yellow,
                                  ),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            Expanded(
                              child: BoxInfo(
                                label: "Hadir",
                                value: hadir.toString(),
                                color: AppColors.greenHadir,
                              ),
                            ),
                            Expanded(
                              child: BoxInfo(
                                label: "Izin",
                                value: izin.toString(),
                                color: AppColors.blueIzin,
                              ),
                            ),
                            Expanded(
                              child: BoxInfo(
                                label: "Sakit",
                                value: sakit.toString(),
                                color: AppColors.yellow,
                              ),
                            ),
                            Expanded(
                              child: BoxInfo(
                                label: "Alpha",
                                value: alpha.toString(),
                                color: AppColors.redAlpha,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    error: (e, s) => textPoppins(
                      "Maaf, jumlah status saat ini belum bisa ditampilkan",
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            attendanceDetail.when(
              data: (attendances) {
                final sortedAttendances = [...attendances];

                sortedAttendances.sort((a, b) {
                  final studentA = a['student'] as Student;
                  final studentB = b['student'] as Student;

                  final aNum = int.parse(studentA.rollNum.trim());
                  final bNum = int.parse(studentB.rollNum.trim());

                  return aNum.compareTo(bNum);
                });

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = sortedAttendances[index];

                    final detail = item['attendanceDetail'] as AttendanceDetail;
                    final student = item['student'] as Student;

                    final status = StatusKehadiranExtension.fromString(
                      detail.status,
                    );

                    return BoxAbsen(
                      nama: student.name,
                      no: student.rollNum,
                      nis: student.nis,
                      nisn: student.nisn,
                      status: status,
                      mainColor: AppColors.black,
                      isResultPage: true,
                    );
                  }, childCount: sortedAttendances.length),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, s) => SliverToBoxAdapter(
                child: textPoppins(
                  "Data Absensi Error",
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
