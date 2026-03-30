import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/attendance_extension.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_provider.dart';
import 'package:absensi_kelas/features/attendance/ui/attendance_result_page.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final attendance = ref.watch(
      attendanceByClassAndMonthProvider((widget.classId, selectedDate))
    );

    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: CustomScrollView(
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
                child: textPoppins(
                  widget.className,
                  color: AppColors.white,
                  fontSize: 14,
                  textAlign: TextAlign.right,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.mainColor,
                      widget.mainColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 16),
                alignment: Alignment.topCenter,
                child: textPagratiNarrow(
                  "Riwayat Absensi",
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        color:
                            isSelected ? AppColors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: isSelected
                                ? widget.mainColor
                                : AppColors.white.withOpacity(0.5)),
                      ),
                      child: Center(
                          child: textPoppins(monthName,
                              color: isSelected
                                  ? widget.mainColor
                                  : AppColors.white,
                              fontSize: 12)),
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
                        "Belum ada data absensi",
                        color: AppColors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }

              final sortedAttendanceList = attendanceList.sortDateTimeDes();

              final uniqueDates = sortedAttendanceList
                  .map((e) => DateTime(
                      e.dateTime.year, e.dateTime.month, e.dateTime.day))
                  .toSet()
                  .toList();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final date = uniqueDates[index];
                    final summaryStatus =
                        ref.watch(summaryProvider((widget.classId, date)));

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: summaryStatus.when(
                        data: (data) {
                          final hadir = data[StatusKehadiran.hadir] ?? 0;
                          final izin = data[StatusKehadiran.izin] ?? 0;
                          final sakit = data[StatusKehadiran.sakit] ?? 0;
                          final alpha = data[StatusKehadiran.alpha] ?? 0;
                      
                          return _attendanceCard(
                              date: date,
                              hadir: hadir.toString(),
                              izin: izin.toString(),
                              sakit: sakit.toString(),
                              alpha: alpha.toString(),
                              navigateToDetail: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultAttendancePage(
                                      schoolClassId: widget.classId,
                                      schoolClassName: widget.className,
                                      totalStudent: widget.totalStudent,
                                      dateTime: date,
                                    ),
                                  ),
                                );
                              },
                          );
                        },
                        error: (e, s) => textPoppins("Maaf terjadi kesalahan",
                            color: AppColors.black),
                        loading: () => const SizedBox.shrink(),
                      ),
                    );
                  },
                  childCount: uniqueDates.length,
                ),
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
              child: Center(
                child: textPoppins("Terjadi kesalahan!"),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16,),
          )
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Widget _attendanceCard({
    required DateTime date,
    required String hadir,
    required String izin,
    required String sakit,
    required String alpha,
    required VoidCallback navigateToDetail,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 8),
                  textPoppins(formatDate(date),
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)
                ],
              ),
              GestureDetector(
                onTap: navigateToDetail,
                child: const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 24,
                  color: AppColors.black,
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatusItem(
                label: "Hadir",
                total: hadir,
                color: AppColors.greenHadir,
              ),
              _StatusItem(
                label: "Izin",
                total: izin,
                color: AppColors.blueIzin,
              ),
              _StatusItem(
                label: "Sakit",
                total: sakit,
                color: AppColors.yellow,
              ),
              _StatusItem(
                label: "Alpha",
                total: alpha,
                color: AppColors.redAlpha,
              ),
            ],
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
          total.toString(),
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
