import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:absensi_kelas/core/constant/app_colors.dart';
import '../widget/box_absen.dart';

// 1. Kelas Utama: StatelessWidget (immutable)
class AbsenPage extends StatefulWidget {
  const AbsenPage({super.key});

  @override
  State<AbsenPage> createState() => _AbsenPageState();
}

// 2. Kelas State: Tempat menampung data & logika (mutable)
class _AbsenPageState extends State<AbsenPage> {

  // Tempat menampung variabel status/state
  late DateTime now;
  String? selectedId; //♦️

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    _updateTime(); // Panggil fungsi untuk memperbarui waktu setiap detik
  }

  //hybrid biar nantik kalok di pakek sampek pergantian hari tu dia bisa berubah tanpa perlu di reload
  void _updateTime() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        now = DateTime.now(); // Perbarui waktu
      });
      _updateTime(); // Panggil lagi untuk terus memperbarui
    });
  }

  String _getMonthName(int month) {
    //♦️
    const List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    String day = now.day.toString().padLeft(
      2,
      '0',
    ); //♦️ jd dia bakal terus ke reload setiap kita jalanin
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 100,
              ), // Memberi ruang untuk tombol

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.bgBlue, AppColors.gradientBgBlue],
                            begin: FractionalOffset(
                              0.4,
                              0.1,
                            ), // 0.0 = kiri/atas, 1.0 = kanan/bawah
                            end: FractionalOffset(
                              0.8,
                              2.0,
                            ), // Nilai di luar 0.0-1.0 akan memperpanjang gradien
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),

                        child: Center(
                          child: textPoppins("Kelas 11 RPL", fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.white),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 80,
                            margin: const EdgeInsets.only(top: 110),
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textInriaSans("Jumlah", fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.white),
                                  textInriaSans("17", color: AppColors.white, fontSize: 32, fontWeight: FontWeight.w700),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Container(
                            width: 100,
                            height: 80,
                            margin: const EdgeInsets.only(top: 110),
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                textInriaSans(day, fontSize: 32, fontWeight: FontWeight.w700,color: AppColors.white),
                                const SizedBox(width: 10),
                                textInriaSans('${_getMonthName(now.month)}\n${now.year}', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  BoxAbsen(
                    id: '1',
                    profile: 'asset/image/profile.jpg',
                    nama: 'Dewa Nyoman Satrya Wiguna',
                    no: '1',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId =
                            '1'; // Set selectedId saat box absen ditekan
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '2',
                    profile: 'asset/image/profile.jpg',
                    nama: 'FELLISHA MAY CRISTIANI DANISIYA PUTRI',
                    no: '2',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '3',
                    profile: 'asset/image/profile.jpg',
                    nama: 'I Gede Ary Wiguna',
                    no: '3',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '4',
                    profile: 'asset/image/profile.jpg',
                    nama: 'I Kadek Adiputra Suastika',
                    no: '4',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '5',
                    profile: 'asset/image/profile.jpg',
                    nama: 'I Kadek Dwi Adi Primananda',
                    no: '5',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '6',
                    profile: 'asset/image/profile.jpg',
                    nama: 'I KADEK SANDI DWIPAYANA PUTRA',
                    no: '6',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '7',
                    profile: 'asset/image/profile.jpg',
                    nama: 'I Made Dwi Premayasa',
                    no: '7',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '8',
                    profile: 'asset/image/profile.jpg',
                    nama: 'I Made Dwik Prawira',
                    no: '8',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '9',
                    profile: 'asset/image/profile.jpg',
                    nama: 'I Putu Anantha Saputra',
                    no: '9',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '10',
                    profile: 'asset/image/profile.jpg',
                    nama: 'Kadek Isaka Lingga Yoni',
                    no: '10',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '11',
                    profile: 'asset/image/profile.jpg',
                    nama: 'Kadek Kirana Purwita Kumala',
                    no: '11',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '12',
                    profile: 'asset/image/profile.jpg',
                    nama: 'Kadek Setia Dharma',
                    no: '12',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '13',
                    profile: 'asset/image/profile.jpg',
                    nama: 'Kaindra Naufal Nurwahid',
                    no: '13',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '14',
                    profile: 'asset/image/profile.jpg',
                    nama: 'KEYSA I\'IME SOFI BAHRAINI',
                    no: '14',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '15',
                    profile: 'asset/image/profile.jpg',
                    nama: 'Muhammad Nurul Najmi Mertayasa',
                    no: '15',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '16',
                    profile: 'asset/image/profile.jpg',
                    nama: 'NI MADE INDIRIANI',
                    no: '16',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                  BoxAbsen(
                    id: '17',
                    profile: 'asset/image/profile.jpg',
                    nama: 'NI PUTU OKTAVIANI',
                    no: '17',
                    status: 'Hadir',
                    onTap: () {
                      setState(() {
                        selectedId = '1';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.button,
                ),
                onPressed: () {},
                child: textPoppins("Kirim", fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.background)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
