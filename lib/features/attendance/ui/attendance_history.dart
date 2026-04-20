import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/attendance_extension.dart';
import 'package:absensi_kelas/core/routes/routes.dart';
import 'package:absensi_kelas/core/utils/date_helper.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_provider.dart';
import 'package:absensi_kelas/features/attendance/widget/attendance_main_card.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:absensi_kelas/widgets/button.dart';

class AttendanceHistoryPage extends ConsumerStatefulWidget {
  final String className;
  final int classId;
  final Color mainColor;
  final String totalStudent;

  const AttendanceHistoryPage({
    super.key,
    required this.className,
    required this.classId,
    required this.mainColor,
    required this.totalStudent,
  });

  @override
  ConsumerState<AttendanceHistoryPage> createState() =>
      _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends ConsumerState<AttendanceHistoryPage> {
  DateTime selectedDate = DateHelper.todayOnly();

  @override
  Widget build(BuildContext context) {
    final attendance = ref.watch(
      attendanceByClassAndMonthProvider((widget.classId, selectedDate)),
    );

    final students = ref.watch(studentByClass(widget.classId));

    final recap = ref.watch(
      attendanceMonthlyRecapProvider((widget.classId, selectedDate)),
    );

    final locale = Localizations.localeOf(context).toString();
    final monthName = DateFormat("MMMM", locale).format(selectedDate);

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              pinned: true,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: widget.mainColor,
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
                      child: const Icon(Icons.arrow_back, color: AppColors.white),
                    ),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.all(8),
                title: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      textPoppins(
                        widget.className,
                        color: AppColors.white,
                        fontSize: 14,
                        textAlign: TextAlign.right,
                      ),
                      textPoppins(
                        monthName,
                        color: AppColors.white,
                        fontSize: 8,
                        textAlign: TextAlign.right,
                      ),
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
                            widget.mainColor,
                            widget.mainColor.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 16,
                      ),
                      alignment: Alignment.topCenter,
                      child: textPagratiNarrow(
                        "Riwayat Absensi",
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
        
                    attendance.when(
                      data: (data) {
                        if (data.isEmpty) return const SizedBox.shrink();
        
                        return Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Button(
                              text: "Rekap Absen",
                              textColor: widget.mainColor,
                              bgColor: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              borderRadius: BorderRadius.circular(10),
                              onPressed: () {
                                recap.when(
                                  data: (recap) {
                                    return students.when(
                                      data: (student) {
                                        return Navigator.pushNamed(
                                          context,
                                          AppRoutes.attendanceRecapPage,
                                          arguments: {
                                            "recap": recap,
                                            "students": student,
                                            "schoolClassName": widget.className,
                                            "month": monthName,
                                            "mainColor": widget.mainColor,
                                          },
                                        );
                                      },
                                      error: (e, s) =>
                                          textPoppins("Maaf Terjadi Kesalahan!"),
                                      loading: () => const SizedBox.shrink(),
                                    );
                                  },
                                  error: (e, s) =>
                                      textPoppins("Maaf Terjadi Kesalahan!"),
                                  loading: () => const SizedBox.shrink(),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      error: (e, s) => textPoppins("Maaf Terjadi Kesalahan!"),
                      loading: () => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: widget.mainColor,
              automaticallyImplyLeading: false,
              toolbarHeight: 20,
              pinned: true,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  itemBuilder: (context, index) {
                    final monthDate = DateTime(DateTime.now().year, index + 1);
                    final isSelected = monthDate.month == selectedDate.month;
        
                    final monthName = DateFormat("MMM", locale).format(monthDate);
        
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = monthDate;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? widget.mainColor
                                : AppColors.white.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Center(
                          child: textPoppins(
                            monthName,
                            color: isSelected
                                ? widget.mainColor
                                : AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            attendance.when(
              data: (attendanceList) {
                if (attendanceList.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: textPoppins(
                          "Belum ada data absensi bulan $monthName",
                          color: AppColors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }
        
                final sortedAttendanceList = attendanceList.sortDateTimeDes();
        
                final uniqueDates = sortedAttendanceList
                    .map(
                      (e) => DateTime(
                        e.date.year,
                        e.date.month,
                        e.date.day,
                      ),
                    )
                    .toSet()
                    .toList();
        
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final date = uniqueDates[index];
                    final summaryStatus = ref.watch(
                      summaryProvider((widget.classId, date)),
                    );
        
                    final attendanceId = attendanceList[index].id;
        
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: summaryStatus.when(
                        data: (data) {
                          final hadir = data[StatusKehadiran.hadir] ?? 0;
                          final izin = data[StatusKehadiran.izin] ?? 0;
                          final sakit = data[StatusKehadiran.sakit] ?? 0;
                          final alpha = data[StatusKehadiran.alpha] ?? 0;
        
                          return AttendanceMainCard(
                            date: date,
                            hadir: hadir.toString(),
                            izin: izin.toString(),
                            sakit: sakit.toString(),
                            alpha: alpha.toString(),
                            navigateToDetail: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.attendanceResultPage,
                                arguments: {
                                  "schoolClassId": widget.classId,
                                  "attendanceId": attendanceId,
                                  "schoolClassName": widget.className,
                                  "totalStudent": widget.totalStudent,
                                  "date": date,
                                },
                              );
                            },
                          );
                        },
                        error: (e, s) => textPoppins(
                          "Maaf terjadi kesalahan",
                          color: AppColors.black,
                        ),
                        loading: () => const SizedBox.shrink(),
                      ),
                    );
                  }, childCount: uniqueDates.length),
                );
              },
              loading: () => const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              error: (e, s) => SliverToBoxAdapter(
                child: Center(child: textPoppins("Terjadi kesalahan!")),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
