import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/utils/date_helper.dart';
import 'package:absensi_kelas/features/attendance/providers/attendance_provider.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceMainCard extends ConsumerWidget {
  final DateTime? date;
  final String? studentName;
  final String hadir;
  final String izin;
  final String sakit;
  final String alpha;
  final Color? mainColor;
  final String? rollNum;
  final VoidCallback? navigateToDetail;
  final int? attendanceId;
  final VoidCallback? onDeleteSuccess;

  const AttendanceMainCard({
    super.key,
    required this.hadir,
    required this.izin,
    required this.sakit,
    required this.alpha,
    this.attendanceId,
    this.mainColor,
    this.studentName,
    this.rollNum,
    this.date,
    this.navigateToDetail,
    this.onDeleteSuccess,
  });

  void _deletePopup({required BuildContext context, required WidgetRef ref}) {
    final locale = Localizations.localeOf(context).toString();
    final dayName = DateHelper.getDayFullName(date!, locale);
    final monthName = DateHelper.getMonthName(date!, locale);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: textPoppins(
            "Yakin ingin hapus data absensi ini?",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              textPoppins(
                "Tanggal : $dayName, ${date!.day} $monthName ${date!.year}",
                fontSize: 14,
                color: AppColors.black,
                fontWeight: FontWeight.w700
              ),
              const SizedBox(height: 16),
              textPoppins(
                "Jumlah Siswa Hadir : $hadir",
                fontSize: 14,
                color: AppColors.black,
              ),
              textPoppins(
                "Jumlah Siswa Izin : $izin",
                fontSize: 14,
                color: AppColors.black,
              ),
              textPoppins(
                "Jumlah Siswa Sakit : $sakit",
                fontSize: 14,
                color: AppColors.black,
              ),
              textPoppins(
                "Jumlah Siswa Alpha: $alpha",
                fontSize: 14,
                color: AppColors.black,
              ),
            ],
          ),
          actions: [
            Button(
              text: "Batal",
              textColor: AppColors.black,
              bgColor: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              borderRadius: BorderRadius.circular(10),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Button(
              text: "Hapus",
              textColor: AppColors.white,
              bgColor: AppColors.redAlpha.withAlpha(230),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              borderRadius: BorderRadius.circular(10),
              onPressed: () async {
                final notifier = ref.watch(attendanceProvider.notifier);

                await notifier.deleteAttendance(attendanceId!);
                onDeleteSuccess?.call();

                if (!context.mounted) return;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          date != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 8),
                        textPoppins(
                          formatDate(date!),
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: PopupMenuButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        color: AppColors.grey,
                        splashRadius: 20,
                        iconSize: 24,
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == "delete") {
                            _deletePopup(context: context, ref: ref);
                          } else if (value == "detail") {
                            navigateToDetail!();
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "delete",
                            child: textPoppins(
                              "Hapus",
                              color: AppColors.black,
                              fontSize: 12,
                            ),
                          ),
                          PopupMenuItem(
                            value: "detail",
                            child: textPoppins(
                              "Detail",
                              color: AppColors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color:
                            mainColor?.withValues(alpha: 0.8) ?? AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: textPoppins(
                          rollNum ?? "0",
                          color: AppColors.white,
                          fontSize: 12,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        studentName ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
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
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}
