import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceMainCard extends StatelessWidget {
  final DateTime? date;
  final String? studentName;
  final String hadir;
  final String izin;
  final String sakit;
  final String alpha;
  final Color? mainColor;
  final String? rollNum;
  final VoidCallback? navigateToDetail;

  const AttendanceMainCard({
    super.key,
    required this.hadir,
    required this.izin,
    required this.sakit,
    required this.alpha,
    this.mainColor,
    this.studentName,
    this.rollNum,
    this.date,
    this.navigateToDetail,
  });

  @override
  Widget build(BuildContext context) {
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
                        textPoppins(formatDate(date!),
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
                )
              : Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: mainColor?.withValues(alpha: 0.8) ?? AppColors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                          child: textPoppins(rollNum ?? "0",
                              color: AppColors.white,
                              fontSize: 12,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Text(
                        studentName ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
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
