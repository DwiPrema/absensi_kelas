import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:absensi_kelas/core/constant/app_colors.dart';

class BoxAbsen extends StatelessWidget {
  final String nama;
  final String no;
  final String nis;
  final String nisn;
  final StatusKehadiran status;
  final Function(StatusKehadiran)? onStatusChanged;
  final Color mainColor;
  final bool isResultPage;

  const BoxAbsen({
    super.key,
    required this.nama,
    required this.no,
    required this.nis,
    required this.nisn,
    required this.status,
    this.onStatusChanged,
    required this.mainColor,
    this.isResultPage = false,
  });

  final List<StatusKehadiran> _statusOptions = const [
    StatusKehadiran.hadir,
    StatusKehadiran.sakit,
    StatusKehadiran.izin,
    StatusKehadiran.alpha,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(130),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: mainColor,
                child: textPoppins(no, fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  nama,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          //Validasi kondisi widget
          isResultPage
              ? Container(
                  width: 122,
                  height: 35,
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: textPoppins(
                      _getStatusLabel(status),
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => _showStatusDialog(context),
                  child: Container(
                    width: 122,
                    height: 35,
                    decoration: BoxDecoration(
                      color: _getStatusColor(status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textPoppins(
                          _getStatusLabel(status),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 24,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _showStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: textPoppins("Pilih Status Absen",
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _statusOptions.map((statusOption) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getStatusColor(statusOption),
                  radius: 5,
                ),
                title: textPoppins(_getStatusLabel(statusOption),
                    color: AppColors.black, fontSize: 14),
                onTap: () {
                  Navigator.pop(context);
                  onStatusChanged?.call(statusOption);
                },
              );
            }).toList(),
          ),
          actions: [
            Button(
                text: "batal",
                textColor: AppColors.black,
                bgColor: Colors.transparent,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  String _getStatusLabel(StatusKehadiran status) {
    switch (status) {
      case StatusKehadiran.hadir:
        return "Hadir";
      case StatusKehadiran.sakit:
        return "Sakit";
      case StatusKehadiran.izin:
        return "Izin";
      case StatusKehadiran.alpha:
        return "Alpha";
    }
  }

  Color _getStatusColor(StatusKehadiran status) {
    switch (status) {
      case StatusKehadiran.hadir:
        return AppColors.greenHadir.withAlpha(180);
      case StatusKehadiran.sakit:
        return AppColors.yellow.withAlpha(180);
      case StatusKehadiran.izin:
        return AppColors.blueIzin.withAlpha(180);
      case StatusKehadiran.alpha:
        return AppColors.redAlpha.withAlpha(180);
    }
  }
}
