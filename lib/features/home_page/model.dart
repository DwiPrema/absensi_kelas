import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constant/app_colors.dart';

class CalendarCard extends StatelessWidget {
  final DateTime date;
  final double cardWidth;
  final double cardHeight;
  final double dayNameFontSize;
  final double dateFontSize;
  final DayType Function(DateTime) getDayType;
  final String Function(DateTime) getDayName;

  const CalendarCard({
    super.key,
    required this.date,
    required this.cardWidth,
    required this.cardHeight,
    required this.dayNameFontSize,
    required this.dateFontSize,
    required this.getDayType,
    required this.getDayName,
  });

  @override
  Widget build(BuildContext context) {
    final dayType = getDayType(date);

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Container(
            width: double.infinity,
            height: cardHeight * 0.85,
            decoration: BoxDecoration(
              color: _getCardColor(dayType),
              borderRadius: BorderRadius.circular(60),
              boxShadow: _getBoxShadow(dayType),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.day.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: dateFontSize,
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(dayType),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  getDayName(date),
                  style: GoogleFonts.poppins(
                    fontSize: dayNameFontSize,
                    fontWeight: FontWeight.w500,
                    color: _getTextColor(dayType).withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<BoxShadow> _getBoxShadow(DayType type) {
    switch (type) {
      case DayType.past:
        return [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            offset: const Offset(-3, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ];
      case DayType.future:
        return [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            offset: const Offset(3, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ];
      case DayType.today:
        return [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            offset: const Offset(0, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ];
    }
  }

  Color _getCardColor(DayType type) {
    switch (type) {
      case DayType.today:
        return AppColors.yellowtgl;
      case DayType.past:
        return Colors.white;
      case DayType.future:
        return Colors.white;
    }
  }

  Color _getTextColor(DayType type) {
    switch (type) {
      case DayType.today:
        return Colors.white;
      case DayType.past:
        return AppColors.yellowtgl;
      case DayType.future:
        return AppColors.yellowtgl;
    }
  }
}

enum DayType { past, today, future }

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
          Text(
            namakelas,
            style: GoogleFonts.pragatiNarrow(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),

          // Jumlah Siswa
          Text(
            jumlahsiswa,
            style: GoogleFonts.pragatiNarrow(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 10),

          // Button Absen di kanan
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
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
              child: Text(
                'Absen',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
