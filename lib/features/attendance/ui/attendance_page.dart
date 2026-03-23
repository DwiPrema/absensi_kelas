import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/utils/date_helper.dart';
import 'package:absensi_kelas/features/attendance/models/attendance_model.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_provider.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_ui_state.dart';
import 'package:absensi_kelas/features/attendance/ui/attendance_result_page.dart';
import 'package:absensi_kelas/features/attendance/widget/box_absen.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
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
    final studentState = ref.watch(studentProviders(widget.schoolClassId));
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
                    /// HEADER
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

                        /// INFO BOX
                        studentState.when(
                          data: (studentList) {
                            final totalStudents = studentList.length;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _topBox("Jumlah", "$totalStudents siswa",
                                    heightHeader),
                                const SizedBox(width: 10),
                                _topBox(day, date, heightHeader),
                              ],
                            );
                          },
                          loading: () => const SizedBox(),
                          error: (_, __) => const SizedBox(),
                        ),
                      ],
                    ),

                    /// LIST SISWA
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
                            final notifier =
                                ref.read(attendanceUIProvider.notifier);

                            for (var student in studentList) {
                              notifier.updateStatus(
                                  student.studentId, StatusKehadiran.hadir);
                            }
                          });
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

                            final status = attendanceUiState[student.studentId];

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
                                    .updateStatus(student.studentId, newStatus);
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
                          final notifier =
                              ref.read(attendanceProvider.notifier);

                          final isExist = await notifier.service
                              .isAlreadyExist(widget.schoolClassId, dateNow);

                          if (!context.mounted) return;

                          if (isExist) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Absensi hari ini sudah ada")),
                            );
                            return;
                          }

                          final detail = uiState.entries.map((entry) {
                            return AttendanceDetail()
                              ..studentId = entry.key
                              ..status = entry.value;
                          }).toList();

                          final attendance = Attendance()
                            ..classId = widget.schoolClassId
                            ..dateTime = dateNow
                            ..details = detail;

                          await notifier.createData(attendance);

                          ref.read(attendanceUIProvider.notifier).reset();

                          ref.invalidate(
                              summaryProvider((widget.schoolClassId, dateNow)));

                          if (!context.mounted) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultAttendancePage(
                                schoolClassId: widget.schoolClassId,
                                schoolClassName: widget.schoolClassName,
                                totalStudent: detail.length.toString(),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              },
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  /// TOP BOX (JUMLAH & TANGGAL)
  Widget _topBox(String title, String value, double heightHeader) {
    return Container(
      width: 100,
      height: 80,
      margin: EdgeInsets.only(top: heightHeader - 40),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textPoppins(
            title,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
          textPoppins(
            value,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}
