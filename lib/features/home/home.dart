import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/features/attendance/ui/absen_page.dart';
import 'package:absensi_kelas/features/home/widgets/calendar/calender.dart';
import 'package:absensi_kelas/features/home/widgets/card/card_kelas.dart';
import 'package:absensi_kelas/features/school_classes/models/school_class_model.dart';
import 'package:absensi_kelas/features/school_classes/providers/school_classes_provider.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constant/app_colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late DateTime today;
  late List<DateTime> weekDays;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    _generateWeekDays();
  }

  void _generateWeekDays() {
    weekDays =
        List.generate(5, (index) => today.add(Duration(days: index - 2)));
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
      'Desember'
    ];
    return months[date.month - 1];
  }

  DayType _getDayType(DateTime date) {
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);
    if (compareDate.isBefore(todayDate)) return DayType.past;
    if (compareDate.isAfter(todayDate)) return DayType.future;
    return DayType.today;
  }

  void _showDialogRemove({required int id, required SchoolClass schClass}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: textPoppins("Yakin ingin hapus data kelas ini?",
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textPoppins("Kelas : ${schClass.schClassName}",
                  fontSize: 12, color: AppColors.black),
              const SizedBox(
                height: 16,
              ),
              textPoppins("Jumlah Siswa : ${schClass.students.length}",
                  fontSize: 12, color: AppColors.black),
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
                }),
            Button(
                text: "Remove",
                textColor: AppColors.white,
                bgColor: AppColors.redAlpha.withAlpha(230),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  final notifier = ref.read(schClassProvider.notifier);

                  notifier.deleteData(id);

                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  void _showDialogData({SchoolClass? schoolClass}) {
    final TextEditingController controller =
        TextEditingController(text: schoolClass?.schClassName ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(schoolClass == null ? "Tambah Kelas" : "Edit Kelas"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Nama Kelas",
              labelStyle: const TextStyle(color: AppColors.black),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.blueCard.withAlpha(100),
                  width: 2,
                ),
              ),
            ),
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
                }),
            Button(
                text: schoolClass == null ? "Tambah" : "Simpan",
                textColor: AppColors.white,
                bgColor: AppColors.blueCard.withAlpha(230),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  final schClassName = controller.text.trim();
                  if (schClassName.isEmpty) return;

                  final notifier = ref.read(schClassProvider.notifier);

                  if (schoolClass == null) {
                    final newClass = SchoolClass()..schClassName = schClassName;
                    notifier.createData(newClass);
                  } else {
                    final updatedClass =
                        schoolClass.copyWith(schClassName: schClassName);
                    notifier.updateData(updatedClass);
                  }

                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final schClassState = ref.watch(schClassProvider);

    final List<Color> mainColors = [
      AppColors.purpleCard,
      AppColors.greenCard,
      AppColors.blueCard,
    ];

    final List<Color> gradientColors = [
      AppColors.purpleGradient,
      AppColors.greenGradient,
      AppColors.blueGradient,
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: textPagratiNarrow('${_getMonthName(today)} ',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCalendarCard(0, 50, 105, 13, 17),
                    _buildCalendarCard(1, 60, 130, 15, 22),
                    _buildCalendarCard(2, 80, 160, 17, 29),
                    _buildCalendarCard(3, 60, 130, 15, 22),
                    _buildCalendarCard(4, 50, 105, 13, 17),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textPagratiNarrow("Pilih Kelas",
                          color: AppColors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                      Button(
                        text: "+ Tambah Kelas",
                        textColor: AppColors.background,
                        bgColor: AppColors.blueCard,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        borderRadius: BorderRadius.circular(10),
                        onPressed: () => _showDialogData(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                schClassState.when(
                  data: (schClassList) {
                    if (schClassList.isEmpty) {
                      return Center(
                          child: textPoppins("Belum Ada Data Kelas",
                              color: AppColors.black));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: schClassList.length,
                      itemBuilder: (context, index) {
                        final schClass = schClassList[index];

                        final mainColor = mainColors[index % mainColors.length];
                        final gradientColor =
                            gradientColors[index % gradientColors.length];
                        return CardKelas(
                          maincolor: mainColor,
                          gradientcolor: gradientColor,
                          namakelas: schClass.schClassName,
                          jumlahsiswa: schClass.students.length.toString(),
                          buttoncolor: AppColors.background.withAlpha(230),
                          onTapEdit: () =>
                              _showDialogData(schoolClass: schClass),
                          onTapRemove: () => _showDialogRemove(
                              id: schClass.schoolClassId, schClass: schClass),
                          onTapAbsen: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AbsenPage()));
                          },
                        );
                      },
                    );
                  },
                  error: (error, stack) =>
                      Center(child: textPoppins("Terjadi kesalahan: $error")),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarCard(int index, double width, double height,
      double nameSize, double dateSize) {
    return CalendarCard(
      date: weekDays[index],
      cardWidth: width,
      cardHeight: height,
      dayNameFontSize: nameSize,
      dateFontSize: dateSize,
      getDayType: _getDayType,
      getDayName: _getDayName,
    );
  }
}
