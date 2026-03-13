import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/features/attendance/ui/absen_page.dart';
import 'package:absensi_kelas/features/home/widgets/calendar/calender.dart';
import 'package:absensi_kelas/features/home/widgets/card/card_kelas.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime today;
  late List<DateTime> weekDays;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    _generateWeekDays();
  }

  void _generateWeekDays() {
    // URUTAN: Past -2, Past -1, Today, Future +1, Future +2
    weekDays = [
      today.subtract(const Duration(days: 2)), // Past -2
      today.subtract(const Duration(days: 1)), // Past -1
      today, // Today
      today.add(const Duration(days: 1)), // Future +1
      today.add(const Duration(days: 2)), // Future +2
    ];
  }

  String _getDayName(DateTime date) {
    const weekdays = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return weekdays[date.weekday - 1];
  }

  String _getMonthName(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[date.month - 1];
  }

  DayType _getDayType(DateTime date) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final compareDate = DateTime(date.year, date.month, date.day);

    if (compareDate.isBefore(todayDate)) return DayType.past;
    if (compareDate.isAfter(todayDate)) return DayType.future;
    return DayType.today;
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                SystemNavigator.pop(); // Keluar dari aplikasi
              },
              child: const Text('Keluar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Month and Year Display
              Semantics(
                header: true,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: textPagratiNarrow('${_getMonthName(today)} ',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                ),
              ),

              // 5 Days Calendar Grid dengan variasi ukuran
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ganti _buildCalendarCard dengan CalendarCard
                  CalendarCard(
                    date: weekDays[0],
                    cardWidth: 50,
                    cardHeight: 105,
                    dayNameFontSize: 13,
                    dateFontSize: 17,
                    getDayType: _getDayType,
                    getDayName: _getDayName,
                  ),
                  CalendarCard(
                    date: weekDays[1],
                    cardWidth: 60,
                    cardHeight: 130,
                    dayNameFontSize: 15,
                    dateFontSize: 22,
                    getDayType: _getDayType,
                    getDayName: _getDayName,
                  ),
                  CalendarCard(
                    date: weekDays[2],
                    cardWidth: 80,
                    cardHeight: 160,
                    dayNameFontSize: 17,
                    dateFontSize: 29,
                    getDayType: _getDayType,
                    getDayName: _getDayName,
                  ),
                  CalendarCard(
                    date: weekDays[3],
                    cardWidth: 60,
                    cardHeight: 130,
                    dayNameFontSize: 15,
                    dateFontSize: 22,
                    getDayType: _getDayType,
                    getDayName: _getDayName,
                  ),
                  CalendarCard(
                    date: weekDays[4],
                    cardWidth: 50,
                    cardHeight: 105,
                    dayNameFontSize: 13,
                    dateFontSize: 17,
                    getDayType: _getDayType,
                    getDayName: _getDayName,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: textPoppins("Pilih Kelas",
                    color: AppColors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              // Di bagian CardKelas
              CardKelas(
                maincolor: AppColors.purpleCard,
                gradientcolor: AppColors.purpleGradient,
                namakelas: 'Kelas 11 RPL',
                jumlahsiswa: 'Jumlah siswa: 30',
                buttoncolor: AppColors.button,
                absen: (kelas) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AbsenPage()),
                  );
                },
              ),
              const SizedBox(height: 20),

              CardKelas(
                maincolor: AppColors.blueCard,
                gradientcolor: AppColors.blueGradient,
                namakelas: 'Kelas 11 RPL',
                jumlahsiswa: 'Jumlah siswa: 30',
                buttoncolor: AppColors.button,
                absen: (kelas) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AbsenPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              CardKelas(
                maincolor: AppColors.greenCard,
                gradientcolor: AppColors.greenGradient,
                namakelas: 'Kelas 11 RPL',
                jumlahsiswa: 'Jumlah siswa: 30',
                buttoncolor: AppColors.button,
                absen: (kelas) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AbsenPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _showExitDialog(context),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(400, 60),
                    backgroundColor: AppColors.button,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: textPoppins(
                    "Keluar",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
