import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CardKelas extends StatelessWidget {
  final Color maincolor;
  final Color gradientcolor;
  final String namakelas;
  final String jumlahsiswa;
  final Color buttoncolor;
  final VoidCallback onTapEdit;
  final VoidCallback onTapRemove;
  final VoidCallback onTapAbsen;

  const CardKelas({
    super.key,
    required this.maincolor,
    required this.gradientcolor,
    required this.namakelas,
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
              textPagratiNarrow(namakelas,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black.withAlpha(200)),
              const SizedBox(width: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: onTapRemove,
                    child: Icon(
                      Icons.delete,
                      size: 24,
                      color: AppColors.black.withAlpha(200),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: onTapEdit,
                    child: Icon(
                      Icons.edit_square,
                      size: 24,
                      color: AppColors.black.withAlpha(200),
                    ),
                  ),
                ],
              )
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.people_alt_rounded, size: 18, color: AppColors.black.withAlpha(180),),
              const SizedBox(width: 8,),
              textPoppins("$jumlahsiswa siswa",
              fontSize: 12, color: Colors.black),
            ],
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Button(
                  text: "Data Siswa",
                  textColor: AppColors.black.withAlpha(200),
                  bgColor: buttoncolor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: () {}),
              const SizedBox(
                width: 24,
              ),
              Button(
                  text: "Mulai Absensi",
                  textColor: AppColors.black.withAlpha(200),
                  bgColor: buttoncolor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  borderRadius: BorderRadius.circular(10),
                  onPressed: onTapAbsen),
            ],
          )
        ],
      ),
    );
  }
}
