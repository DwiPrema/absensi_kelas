import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CardKelas extends StatelessWidget {
  // Properties / Atribut
  final Color maincolor;
  final Color gradientcolor;
  final String namakelas;
  final String jumlahsiswa;
  final Color buttoncolor;
  final Function(String)
      absen; // 👈 UBAH JADI Function(String) BUKAN VoidCallback

  // Constructor
  const CardKelas({
    super.key,
    required this.maincolor,
    required this.gradientcolor,
    required this.namakelas,
    required this.jumlahsiswa,
    required this.buttoncolor,
    required this.absen, // Terima callback DENGAN parameter String
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Nama Kelas
          textPagratiNarrow(namakelas,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.white),
          const SizedBox(height: 4),

          // Jumlah Siswa
          textPagratiNarrow(jumlahsiswa, fontSize: 20, color: Colors.white),
          const SizedBox(height: 10),

          // Button Absen di kanan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // ✅ PANGGIL callback DENGAN parameter namakelas
                  absen(namakelas);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttoncolor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: textPoppins("Absen",
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SiswaPresentation()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttoncolor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: textPoppins("Lihat Data",
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
