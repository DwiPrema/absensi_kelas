import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/student_extension.dart';
import 'package:absensi_kelas/core/routes/routes.dart';
import 'package:absensi_kelas/core/utils/date_helper.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_detail_provider.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_provider.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_ui_state.dart';
import 'package:absensi_kelas/features/attendance/widget/box_absen.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/widgets/box.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AttendancePage extends ConsumerStatefulWidget {
  final Color headerColor;
  final Color gradientHeaderColor;
  final int schoolClassId;
  final String schoolClassName;

  const AttendancePage({
    super.key,
    required this.headerColor,
    required this.gradientHeaderColor,
    required this.schoolClassId,
    required this.schoolClassName,
  });

  @override
  ConsumerState<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    _initialized = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(attendanceUIProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentByClass(widget.schoolClassId));
    final attendanceUiState = ref.watch(attendanceUIProvider);

    final dateNow = DateHelper.todayOnly();

    final locale = Localizations.localeOf(context).toString();
    final String day = DateFormat('EEEE', locale).format(dateNow);
    final String date = DateFormat('dd MMM', locale).format(dateNow);

    final double heightHeader = 150 + MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.grey,
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
                          height: heightHeader,
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
                        Positioned(
                          top: MediaQuery.of(context).padding.top,
                          left: 16,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: AppColors.black.withAlpha(50),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        studentState.when(
                          data: (studentList) {
                            final totalStudents = studentList.length;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BoxInfo(
                                  label: "Jumlah",
                                  value: "$totalStudents siswa",
                                  color: AppColors.yellow,
                                  heightHeader: heightHeader,
                                  width: 100,
                                  height: 80,
                                ),
                                const SizedBox(width: 10),
                                BoxInfo(
                                  label: day,
                                  value: date,
                                  color: AppColors.yellow,
                                  heightHeader: heightHeader,
                                  width: 100,
                                  height: 80,
                                ),
                              ],
                            );
                          },
                          loading: () => const SizedBox(),
                          error: (_, _) => const SizedBox(),
                        ),
                      ],
                    ),
                    studentState.when(
                      data: (studentList) {
                        if (studentList.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Center(
                              child: textPoppins(
                                "Belum ada data siswa",
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }

                        if (!_initialized) {
                          _initialized = true;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            final notifier = ref.read(
                              attendanceUIProvider.notifier,
                            );

                            for (var student in studentList) {
                              notifier.updateStatus(
                                student.id,
                                StatusKehadiran.hadir,
                              );
                            }
                          });
                        }

                        final sortedList = studentList.sortByRollNum();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sortedList.length,
                          itemBuilder: (context, index) {
                            final student = sortedList[index];

                            final status = attendanceUiState[student.id];

                            return BoxAbsen(
                              nama: student.name,
                              no: student.rollNum.toString(),
                              nis: student.nis,
                              nisn: student.nisn,
                              mainColor: widget.headerColor,
                              status: status ?? StatusKehadiran.hadir,
                              onStatusChanged: (newStatus) {
                                ref
                                    .read(attendanceUIProvider.notifier)
                                    .updateStatus(student.id, newStatus);
                              },
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
            studentState.when(
              data: (studentList) {
                final totalStudents = studentList.length;

                if (totalStudents == 0) {
                  return const SizedBox.shrink();
                }

                return Positioned(
                  bottom: 24,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Button(
                      text: "Simpan",
                      textColor: AppColors.white,
                      bgColor: widget.headerColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      borderRadius: BorderRadius.circular(50),
                      paddingHorizontal: 50,
                      paddingVertical: 16,
                      onPressed: () async {
                        final uiState = ref.read(attendanceUIProvider);
                        final notifier = ref.read(attendanceProvider.notifier);
                        final detailNotifier = ref.read(
                          attendanceDetailProvider.notifier,
                        );

                        final existingAttendance = await notifier
                            .getAttendanceByDate(widget.schoolClassId, dateNow);

                        if (!context.mounted) return;

                        if (existingAttendance != null) {
                          _isExistAttendance(
                            buildContext: context,
                            schClassId: widget.schoolClassId,
                            schClassName: widget.schoolClassName,
                            totalStudent: uiState.entries.length.toString(),
                            attendanceId:
                                existingAttendance.id, // ✅ aman (tidak null)
                          );
                          return;
                        }

                        final attendanceId = await notifier.createAttendance(
                          classId: widget.schoolClassId,
                          date: dateNow,
                        );

                        for (final entry in uiState.entries) {
                          await detailNotifier.addDetail(
                            attendanceId: attendanceId,
                            studentId: entry.key,
                            status: entry.value,
                          );
                        }

                        ref.read(attendanceUIProvider.notifier).reset();
                        ref.invalidate(summaryProvider);

                        if (!context.mounted) return;

                        Navigator.pushNamed(
                          context,
                          AppRoutes.attendanceResultPage,
                          arguments: {
                            "schoolClassId": widget.schoolClassId,
                            "schoolClassName": widget.schoolClassName,
                            "totalStudent": uiState.entries.length.toString(),
                            "attendanceId": attendanceId,
                            "date": dateNow,
                          },
                        );
                      },
                    ),
                  ),
                );
              },
              loading: () => const SizedBox(),
              error: (_, _) => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

void _isExistAttendance({
  required BuildContext buildContext,
  required int schClassId,
  required String schClassName,
  required String totalStudent,
  required int attendanceId,
}) {
  showDialog(
    context: buildContext,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: textPoppins(
          "Absensi hari ini sudah ada!",
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: textPoppins(
            "Mohon untuk absen lagi besok,\nIngin lihat absensi hari ini?",
            color: AppColors.black,
          ),
        ),
        actions: [
          Button(
            text: "Batal",
            textColor: AppColors.black,
            bgColor: AppColors.background,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            borderRadius: BorderRadius.circular(10),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
          Button(
            text: "Lihat Absen",
            textColor: AppColors.white,
            bgColor: AppColors.blueCard,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            borderRadius: BorderRadius.circular(10),
            onPressed: () {
              Navigator.pop(dialogContext);
              
              Navigator.pushNamed(
                buildContext,
                AppRoutes.attendanceResultPage,
                arguments: {
                  "schoolClassId": schClassId,
                  "schoolClassName": schClassName,
                  "totalStudent": totalStudent,
                  "attendanceId": attendanceId,
                  "date" : DateHelper.todayOnly(),
                },
              );
            },
          ),
        ],
      );
    },
  );
}
