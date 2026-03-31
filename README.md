# 📚 Absensi Kelas App

Aplikasi **Absensi Kelas** berbasis **Flutter** dan **Isar Database** untuk membantu pencatatan kehadiran siswa secara **cepat, ringan, dan efisien**.

Project ini merupakan **rilis awal yang stabil**, dengan fokus pada implementasi fitur inti absensi yang sederhana namun powerful.

---

## ✨ Preview

> 📸 Screenshot dan 🎥 video demo akan ditambahkan di sini

---

## 🚀 Tech Stack

| Teknologi | Deskripsi                        |
| --------- | -------------------------------- |
| Flutter   | Framework UI cross-platform      |
| Riverpod  | State management modern          |
| Isar      | Local NoSQL database super cepat |
| Dart      | Bahasa pemrograman utama         |

---

## 🎯 Fitur Utama

* ✅ Input absensi siswa per kelas
* ✅ Riwayat absensi harian
* ✅ Rekap absensi bulanan per siswa
* ✅ Sorting berdasarkan nomor absen
* ✅ UI modern menggunakan Sliver
* 🚧 (Coming Soon) Export rekap absensi

---

## 📌 Mengapa Menggunakan Flutter 3.16.9?

Project ini menggunakan versi ini untuk menjaga stabilitas pengembangan:

* ✅ Kompatibel dengan **Isar 3.x**
* ✅ Menghindari masalah Android Gradle Plugin (AGP)
* ✅ Menghindari breaking changes pada versi terbaru
* ✅ Lebih stabil untuk pengembangan jangka panjang

> ⚠️ Isar belum sepenuhnya kompatibel dengan Flutter versi terbaru saat project ini dibuat.

---

## 🔧 Flutter Version Management (FVM)

Project ini menggunakan **FVM (Flutter Version Management)** untuk memastikan konsistensi versi Flutter.

### 📌 Versi yang Dibutuhkan

```
Flutter 3.16.9
```

Versi ini dikunci pada file:

```
.fvmrc
```

---

## ⚙️ Instalasi FVM

Jika belum memiliki FVM:

```bash
dart pub global activate fvm
```

---

## 📦 Setup Project

```bash
fvm install
fvm use
fvm flutter pub get
```

---

## ▶️ Menjalankan Aplikasi

```bash
fvm flutter run
```

---

## 📁 Struktur Project (Simplified)

```
lib/
├── core/
│   ├── constant/
│   ├── database/
│   ├── enums/
│   ├── extensions/
│   ├── routes/
│   └── utils/
│
├── features/
│   ├── attendance/
│   ├── home/
│   ├── school_classes/
│   └── students/
│
├── widgets/
└── main.dart
```

---

## 🎯 Tujuan Project

Project ini dibuat untuk:

* 📚 Tugas Sekolah & Media pembelajaran Flutter & Riverpod
* 🧠 Implementasi database lokal menggunakan Isar
* 💼 Portofolio pengembangan aplikasi mobile
* 🚀 Memudahkan perangkat kelas / guru disekolah untuk mengabsen & merekap siswa

---

## ⭐ Dukungan

Jika project ini membantu, jangan lupa:

* ⭐ Star repository
* 🍴 Fork project
* 🧠 Berikan feedback

---

## 🔥 Future Improvements

* 📊 Statistik kehadiran (chart)
* 📤 Export data rekap absen ke PDF / Excel
