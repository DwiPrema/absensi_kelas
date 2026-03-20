import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:absensi_kelas/core/constant/app_colors.dart';

class BoxAbsen extends StatefulWidget {
  final String nama;
  final String no;
  final String? nis;
  final String? nisn;
  final StatusKehadiran status;
  final Function(StatusKehadiran)? onStatusChanged;

  const BoxAbsen({
    super.key,
    required this.nama,
    required this.no,
    this.nis,
    this.nisn,
    this.status = StatusKehadiran.hadir,
    this.onStatusChanged,
  });

  @override
  State<BoxAbsen> createState() => _BoxAbsenState();
}

class _BoxAbsenState extends State<BoxAbsen> {
  late StatusKehadiran _currentStatus;

  final List<StatusKehadiran> _statusOptions = [
    StatusKehadiran.hadir,
    StatusKehadiran.sakit,
    StatusKehadiran.izin,
    StatusKehadiran.alpha,
  ];

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.status;
  }

  void _changeStatus(StatusKehadiran newStatus) {
    setState(() {
      _currentStatus = newStatus;
    });

    widget.onStatusChanged?.call(newStatus);
  }

  void _showStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: textPoppins(
            "Pilih Status Absen",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _statusOptions.map((status) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getStatusColor(status),
                    ),
                  ),
                  title: textPoppins(
                    _getStatusLabel(status),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _changeStatus(status);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: textPoppins(
                "Batal",
                color: AppColors.black.withAlpha(190),
              ),
            ),
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
        return AppColors.greenHadir;
      case StatusKehadiran.sakit:
        return AppColors.yellow;
      case StatusKehadiran.izin:
        return AppColors.blueIzin;
      case StatusKehadiran.alpha:
        return AppColors.redAlpha;
    }
  }

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
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 25,
                width: 25,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: textPoppins(
                    widget.no,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Text(
                widget.nama,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: _showStatusDialog,
            child: Container(
              width: 122,
              height: 35,
              decoration: BoxDecoration(
                color: _getStatusColor(_currentStatus),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: textPagratiNarrow(
                  _getStatusLabel(_currentStatus),
                  fontSize: 16,
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
