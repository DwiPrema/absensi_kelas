import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/features/school_classes/models/school_class_model.dart';
import 'package:absensi_kelas/features/students/models/student_model.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/features/students/widgets/card_student.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_field_widget.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentPage extends ConsumerStatefulWidget {
  final Color mainColor;
  final SchoolClass schoolClass;

  const StudentPage(
      {super.key, required this.mainColor, required this.schoolClass});

  @override
  ConsumerState<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends ConsumerState<StudentPage> {
  ///popup untuk validasi
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// popup untuk tambah / update data
  void _showDialogData({Student? student}) {
    final TextEditingController nameController =
        TextEditingController(text: student?.name ?? "");

    final TextEditingController rollNumController =
        TextEditingController(text: student?.rollNum.toString());

    final TextEditingController nisController =
        TextEditingController(text: student?.nis);

    final TextEditingController nisnController =
        TextEditingController(text: student?.nisn);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title:
              Text(student == null ? "Tambah Data Siswa" : "Edit Data Siswa"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 16,
                ),
                textFieldWidget(
                    labelText: "Nama Siswa", controller: nameController),
                const SizedBox(
                  height: 16,
                ),
                textFieldWidget(
                    labelText: "No Absen",
                    controller: rollNumController,
                    maxLength: 2),
                const SizedBox(
                  height: 16,
                ),
                textFieldWidget(
                    labelText: "NIS (Opsional)",
                    controller: nisController,
                    maxLength: 10),
                const SizedBox(
                  height: 16,
                ),
                textFieldWidget(
                    labelText: "NISN (Opsional)",
                    controller: nisnController,
                    maxLength: 15),
              ],
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
                text: student == null ? "Tambah" : "Simpan",
                textColor: AppColors.white,
                bgColor: AppColors.blueCard.withAlpha(230),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                borderRadius: BorderRadius.circular(10),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final studentName = nameController.text.trim();
                  final rollNum = rollNumController.text.trim();
                  final nis = nisController.text.trim();
                  final nisn = nisnController.text.trim();

                  if (studentName.isEmpty) {
                    _showError("Nama siswa wajib diisi");
                    return;
                  }

                  if (rollNum.isEmpty) {
                    _showError("Nomor absen wajib diisi");
                    return;
                  }

                  if (int.tryParse(rollNum) == null) {
                    _showError("Nomor absen harus berupa angka");
                    return;
                  }

                  final notifier = ref.read(
                      studentProviders(widget.schoolClass.schoolClassId)
                          .notifier);

                  if (student == null) {
                    final newClass = Student()
                      ..name = studentName
                      ..rollNum = rollNum
                      ..nis = nis.isEmpty ? '-' : nis
                      ..nisn = nisn.isEmpty ? '-' : nisn
                      ..schClass.value = widget.schoolClass;

                    await notifier.createData(newClass);
                  } else {
                    final updatedClass = student.copyWith(
                      name: studentName,
                      rollNum: rollNum,
                      nis: nis,
                      nisn: nisn,
                    );
                    await notifier.updateData(updatedClass);
                  }

                  if (!context.mounted) return;

                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  /// popup untuk remove data
  void _removeAlert(Student student) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.background,
            title: textPoppins("Yakin ingin menghapus data siswa ini?",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 24,
                ),
                textPoppins("Nama : ${student.name}",
                    fontSize: 16,
                    color: AppColors.black,
                    textAlign: TextAlign.left),
                const SizedBox(
                  height: 16,
                ),
                textPoppins("Nomor Absen : ${student.rollNum}",
                    fontSize: 14,
                    color: AppColors.black,
                    textAlign: TextAlign.left),
                const SizedBox(
                  height: 16,
                ),
                textPoppins("NIS/NISN : ${student.nis} / ${student.nisn}",
                    fontSize: 14,
                    color: AppColors.black,
                    textAlign: TextAlign.left),
                const SizedBox(
                  height: 16,
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
                  }),
              Button(
                text: "Hapus",
                textColor: AppColors.white,
                bgColor: AppColors.redAlpha,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                borderRadius: BorderRadius.circular(10),
                onPressed: () async {
                  final notifier = ref.read(
                      studentProviders(widget.schoolClass.schoolClassId)
                          .notifier);

                  await notifier.deleteData(student.studentId);

                  if (!context.mounted) return;
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final student =
        ref.watch(studentProviders(widget.schoolClass.schoolClassId));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.grey,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            slivers: [
              SliverAppBar(
                elevation: 0.0,
                backgroundColor: widget.mainColor,
                expandedHeight: 250,
                collapsedHeight: 95,
                pinned: true,
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: AppColors.black.withAlpha(50),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 30),
                    child: Column(
                      children: [
                        Center(
                          child: textPagratiNarrow("Data Siswa",
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textPoppins(widget.schoolClass.schClassName,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            Button(
                              text: "Tambah Data",
                              textColor: AppColors.black,
                              bgColor: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              borderRadius: BorderRadius.circular(5),
                              onPressed: () => _showDialogData(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    child: Center(
                      child: Container(
                        width: 70,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.black.withAlpha(50),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SliverAppBar(
              //   pinned: true,
              //   backgroundColor: widget.mainColor,
              //   automaticallyImplyLeading: false,
              //   flexibleSpace: FlexibleSpaceBar(
              // background: Container(
              //   decoration: const BoxDecoration(
              //       color: AppColors.grey,
              //       borderRadius:
              //           BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
              //   child: Center(
              //     child: Container(
              //       width: 70,
              //       height: 5,
              //       margin: const EdgeInsets.symmetric(vertical: 16),
              //       decoration: BoxDecoration(
              //         color: AppColors.black.withAlpha(50),
              //         borderRadius: BorderRadius.circular(100),
              //       ),
              //     ),
              //   ),
              // ),
              //   ),
              // ),
              student.when(
                data: (studentList) {
                  if (studentList.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: textPoppins(
                            "Belum ada data siswa",
                            color: AppColors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }

                  final sortedList = [...studentList];

                  sortedList.sort(
                    (a, b) =>
                        int.parse(a.rollNum).compareTo(int.parse(b.rollNum)),
                  );

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final student = sortedList[index];

                        return CardStudent(
                          name: student.name,
                          rollNum: student.rollNum.toString(),
                          mainColor: widget.mainColor,
                          nis: student.nis,
                          nisn: student.nisn,
                          onTapRemove: () => _removeAlert(student),
                          onTapEdit: () => _showDialogData(student: student),
                        );
                      },
                      childCount: sortedList.length,
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (e, s) => SliverToBoxAdapter(
                  child: Center(
                    child: textPoppins("Terjadi kesalahan!"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
