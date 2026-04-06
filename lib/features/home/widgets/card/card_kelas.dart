import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/routes/routes.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CardKelas extends StatelessWidget {
  final Color maincolor;
  final Color gradientcolor;
  final SchoolClassesData schoolClass;
  final String jumlahsiswa;
  final Color buttoncolor;
  final VoidCallback onTapEdit;
  final VoidCallback onTapRemove;
  final VoidCallback onTapAbsen;

  const CardKelas({
    super.key,
    required this.maincolor,
    required this.gradientcolor,
    required this.schoolClass,
    required this.jumlahsiswa,
    required this.buttoncolor,
    required this.onTapEdit,
    required this.onTapRemove,
    required this.onTapAbsen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [maincolor, gradientcolor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textPagratiNarrow(schoolClass.name,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black.withAlpha(200)),
              const SizedBox(width: 16),
              PopupMenuButton(
                  color: AppColors.background,
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == "edit") {
                      onTapEdit();
                    } else if (value == "delete") {
                      onTapRemove();
                    } else if (value == "kelola data siswa") {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.studentPage,
                        arguments: {
                          "mainColor": maincolor,
                          "schoolClass": schoolClass,
                        },
                      );
                    } else if (value == "attendance history") {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.attendanceHistoryPage,
                        arguments: {
                          "schoolClassId": schoolClass.id,
                          "schoolClassName": schoolClass.name,
                          "mainColor": maincolor,
                          "totalStudent": jumlahsiswa,
                        },
                      );
                    }
                  },
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "edit",
                          child: textPoppins("Edit",
                              color: AppColors.black, fontSize: 12),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: textPoppins("Hapus",
                              color: AppColors.black, fontSize: 12),
                        ),
                        PopupMenuItem(
                          value: "kelola data siswa",
                          child: textPoppins("Kelola Data Siswa",
                              color: AppColors.black, fontSize: 12),
                        ),
                        PopupMenuItem(
                          value: "attendance history",
                          child: textPoppins("Riwayat Absensi",
                              color: AppColors.black, fontSize: 12),
                        )
                      ]),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.people_alt_rounded,
                size: 18,
                color: AppColors.black.withAlpha(180),
              ),
              const SizedBox(
                width: 8,
              ),
              textPoppins("$jumlahsiswa siswa",
                  fontSize: 12, color: Colors.black),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Button(
                text: "Mulai Absensi",
                textColor: AppColors.black.withAlpha(230),
                bgColor: buttoncolor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                borderRadius: BorderRadius.circular(10),
                onPressed: onTapAbsen),
          ),
        ],
      ),
    );
  }
}
