import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/routes/routes.dart';
import 'package:absensi_kelas/core/utils/date_helper.dart';
import 'package:absensi_kelas/features/home/widgets/calendar/calender.dart';
import 'package:absensi_kelas/features/home/widgets/card/card_kelas.dart';
import 'package:absensi_kelas/features/school_classes/providers/school_classes_provider.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_field_widget.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constant/app_colors.dart';

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
    today = DateHelper.todayOnly();
    _generateWeekDays();
  }

  void _generateWeekDays() {
    weekDays = List.generate(
      5,
      (index) => today.add(Duration(days: index - 2)),
    );
  }

  String _getDayName(DateTime date, String locale) {
    return DateFormat('EEE', locale).format(date).toString();
  }

  String _getMonthName(String locale) {
    return DateFormat('MMMM', locale).format(DateTime.now());
  }

  DayType _getDayType(DateTime date) {
    final todayDate = DateHelper.todayOnly();
    final compareDate = DateTime(date.year, date.month, date.day);
    if (compareDate.isBefore(todayDate)) return DayType.past;
    if (compareDate.isAfter(todayDate)) return DayType.future;
    return DayType.today;
  }

  void _showDialogRemove({
    required int id,
    required SchoolClassesData schClass,
    required String jumlahSiswa,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: textPoppins(
            "Yakin ingin hapus data kelas ini?",
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textPoppins(
                "Perhatian! : Menghapus data kelas ini akan menghapus seluruh data siswa serta absensi yang ada di dalamnya",
                color: AppColors.redAlpha.withAlpha(180),
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 50),
              textPoppins(
                "Kelas : ${schClass.name}",
                fontSize: 14,
                color: AppColors.black,
              ),
              const SizedBox(height: 16),
              textPoppins(
                "Jumlah Siswa : $jumlahSiswa",
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
                final notifier = ref.read(schoolClassProvider.notifier);

                await notifier.deleteClass(id);

                if (!context.mounted) return;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogData({SchoolClassesData? schoolClass}) {
    final TextEditingController controller = TextEditingController(
      text: schoolClass?.name.toString() ?? "",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            schoolClass == null ? "Tambah Data Kelas" : "Edit Data Kelas",
          ),
          content: textFieldWidget(
            labelText: "Nama Kelas",
            controller: controller,
            textFieldType: TextFieldType.outline,
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
              text: schoolClass == null ? "Tambah" : "Simpan",
              textColor: AppColors.white,
              bgColor: AppColors.blueCard.withAlpha(230),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              borderRadius: BorderRadius.circular(10),
              onPressed: () async {
                final schClassName = controller.text.trim();
                if (schClassName.isEmpty) return;

                final notifier = ref.read(schoolClassProvider.notifier);

                if (schoolClass == null) {
                  notifier.addClass(schClassName);
                } else {
                  notifier.updateClass(schoolClass.id, schClassName);
                }

                if (!context.mounted) return;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCalendarCard(
    int index,
    double width,
    double height,
    double nameSize,
    double dateSize,
    String locale,
  ) {
    return CalendarCard(
      date: weekDays[index],
      cardWidth: width,
      cardHeight: height,
      dayNameFontSize: nameSize,
      dateFontSize: dateSize,
      getDayType: _getDayType,
      getDayName: (date) => _getDayName(date, locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    final schClassState = ref.watch(schoolClassProvider);

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

    final locale = Localizations.localeOf(context).toString();

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
                    child: textPagratiNarrow(
                      '${_getMonthName(locale)} ',
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCalendarCard(0, 50, 105, 13, 17, locale),
                    _buildCalendarCard(1, 60, 130, 15, 22, locale),
                    _buildCalendarCard(2, 80, 160, 17, 29, locale),
                    _buildCalendarCard(3, 60, 130, 15, 22, locale),
                    _buildCalendarCard(4, 50, 105, 13, 17, locale),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textPagratiNarrow(
                        "Pilih Kelas",
                        color: AppColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      Button(
                        text: "+ Tambah Kelas",
                        textColor: AppColors.background,
                        bgColor: AppColors.blueCard,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        borderRadius: BorderRadius.circular(10),
                        onPressed: () => _showDialogData(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                schClassState.when(
                  data: (schClassList) {
                    if (schClassList.isEmpty) {
                      return Center(
                        child: textPoppins(
                          "Belum Ada Data Kelas",
                          color: AppColors.black,
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: schClassList.length,
                      itemBuilder: (context, index) {
                        final schClass = schClassList[index];

                        final student = ref.watch(
                          studentByClass(schClass.id)
                        );
                        final students = student.value ?? [];
                        final totalStudent = students.length;

                        final mainColor = mainColors[index % mainColors.length];
                        final gradientColor =
                            gradientColors[index % gradientColors.length];
                        return CardKelas(
                          maincolor: mainColor,
                          gradientcolor: gradientColor,
                          schoolClass: schClass,
                          jumlahsiswa: totalStudent.toString(),
                          buttoncolor: AppColors.background,
                          onTapEdit: () =>
                              _showDialogData(schoolClass: schClass),
                          onTapRemove: () => _showDialogRemove(
                            id: schClass.id,
                            schClass: schClass,
                            jumlahSiswa: totalStudent.toString(),
                          ),
                          onTapAbsen: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.attendancePage,
                              arguments: {
                                "headerColor": mainColor,
                                "gradientColor": gradientColor,
                                "schoolClassId": schClass.id,
                                "schoolClassName": schClass.name,
                              },
                            );
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
}
