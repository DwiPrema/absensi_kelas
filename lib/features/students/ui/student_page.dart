import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/extensions/student_extension.dart';
import 'package:absensi_kelas/features/students/providers/student_provider.dart';
import 'package:absensi_kelas/features/students/widgets/card_student.dart';
import 'package:absensi_kelas/widgets/button.dart';
import 'package:absensi_kelas/widgets/text_field_widget.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentPage extends ConsumerStatefulWidget {
  final Color mainColor;
  final SchoolClassesData schoolClass;

  const StudentPage({
    super.key,
    required this.mainColor,
    required this.schoolClass,
  });

  @override
  ConsumerState<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends ConsumerState<StudentPage> {
  ///popup untuk validasi
  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// popup untuk tambah / update data
  void _showDialogData({Student? student}) {
    final TextEditingController nameController = TextEditingController(
      text: student?.name ?? "",
    );

    final TextEditingController rollNumController = TextEditingController(
      text: student?.rollNum.toString(),
    );

    final TextEditingController nisController = TextEditingController(
      text: student?.nis,
    );

    final TextEditingController nisnController = TextEditingController(
      text: student?.nisn,
    );

    Gender? selectedGender = student?.gender.toGender();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                student == null ? "Tambah Data Siswa" : "Edit Data Siswa",
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    textFieldWidget(
                      labelText: "Nama Siswa",
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    textFieldWidget(
                      labelText: "No Absen",
                      controller: rollNumController,
                      maxLength: 2,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Gender>(
                      dropdownColor: AppColors.white,
                      initialValue: selectedGender,
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.black.withAlpha(100),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        border: const UnderlineInputBorder(),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.blueCard.withAlpha(100),
                            width: 2,
                          ),
                        ),
                      ),
                      items: Gender.values.map((gender) {
                        return DropdownMenuItem<Gender>(
                          value: gender,
                          child: textPoppins(
                            gender.value,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    textFieldWidget(
                      labelText: "NIS (Opsional)",
                      controller: nisController,
                      maxLength: 10,
                    ),
                    const SizedBox(height: 16),
                    textFieldWidget(
                      labelText: "NISN (Opsional)",
                      controller: nisnController,
                      maxLength: 15,
                    ),
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
                  },
                ),
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

                    if (selectedGender == null) {
                      _showError("Gender wajib dipilih");
                      return;
                    }

                    final notifier = ref.read(studentProvider.notifier);

                    if (student == null) {
                      await notifier.addStudent(
                        name: studentName,
                        rollNum: rollNum,
                        gender: selectedGender!.value,
                        classId: widget.schoolClass.id,
                        nis: nis.isEmpty ? "-" : nis,
                        nisn: nisn.isEmpty ? "-" : nisn,
                      );
                    } else {
                      await notifier.updateStudent(
                        id: student.id,
                        name: studentName,
                        rollNum: rollNum,
                        gender: selectedGender!.value,
                        nis: nis.isEmpty ? "-" : nis,
                        nisn: nisn.isEmpty ? "-" : nisn,
                      );
                    }

                    ref.invalidate(studentByClass(widget.schoolClass.id));

                    if (!context.mounted) return;

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
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
          title: textPoppins(
            "Yakin ingin menghapus data siswa ini?",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              textPoppins(
                "Nama : ${student.name}",
                fontSize: 16,
                color: AppColors.black,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              textPoppins(
                "Nomor Absen : ${student.rollNum}",
                fontSize: 14,
                color: AppColors.black,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              textPoppins(
                "Gender : ${student.gender}",
                fontSize: 14,
                color: AppColors.black,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              textPoppins(
                "NIS/NISN : ${student.nis} / ${student.nisn}",
                fontSize: 14,
                color: AppColors.black,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
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
              bgColor: AppColors.redAlpha,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              borderRadius: BorderRadius.circular(10),
              onPressed: () async {
                final notifier = ref.watch(studentProvider.notifier);

                await notifier.deleteStudent(student.id);

                ref.invalidate(studentByClass(widget.schoolClass.id));

                if (!context.mounted) return;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = ref.watch(studentByClass(widget.schoolClass.id));

    final paddingTopSafeArea = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.grey,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
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
                  padding: EdgeInsets.fromLTRB(
                    16,
                    paddingTopSafeArea + 24,
                    16,
                    16,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: textPagratiNarrow(
                          "Data Siswa",
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textPoppins(
                                widget.schoolClass.name,
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                textAlign: TextAlign.left,
                              ),
                              student.when(
                                data: (data) {
                                  final totalStudent = data.length.toString();

                                  return textPoppins(
                                    "$totalStudent siswa",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.left,
                                  );
                                },
                                error: (e, s) => textPoppins(
                                  "-",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.left,
                                ),
                                loading: () => textPoppins(
                                  "-",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.left,
                                ),
                              ),
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
                      topRight: Radius.circular(35),
                    ),
                  ),
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

                final sortedList = studentList.sortByRollNum();

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final student = sortedList[index];

                    return CardStudent(
                      name: student.name,
                      rollNum: student.rollNum.toString(),
                      gender: student.gender,
                      mainColor: widget.mainColor,
                      nis: student.nis,
                      nisn: student.nisn,
                      onTapRemove: () => _removeAlert(student),
                      onTapEdit: () => _showDialogData(student: student),
                    );
                  }, childCount: sortedList.length),
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
                child: Center(child: textPoppins("Terjadi kesalahan!")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
