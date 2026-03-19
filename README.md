# 📚 Aplikasi Absensi Kelas (Flutter + Isar)

Aplikasi **Absensi Kelas** sederhana yang dibuat menggunakan **Flutter** dan **Isar Database**.
Aplikasi ini dirancang untuk membantu pencatatan kehadiran siswa pada beberapa kelas secara cepat dan efisien.

Project ini merupakan **rilis awal yang stabil**, dengan fokus pada implementasi fitur inti absensi.

---

## 🚀 Teknologi yang Digunakan

* **Flutter**: 3.16.9
* **State Management**: Riverpod
* **Dart**: 3.2.6
* **Database**: Isar
* **Platform**: Android, iOS, Web, Desktop

---

## 📌 Mengapa Menggunakan Flutter 3.16.9?

Project ini secara sengaja menggunakan **Flutter 3.16.9** karena beberapa alasan berikut:

* ✅ **Kompatibilitas stabil dengan Isar 3.x**
* ✅ Menghindari masalah **Android Gradle Plugin (AGP) namespace**
* ✅ Menghindari perubahan besar pada Flutter versi terbaru
* ✅ Menjaga konsistensi environment pengembangan

> ⚠️ Pada saat pengembangan, **Isar belum sepenuhnya kompatibel dengan versi Flutter terbaru**.
> Oleh karena itu, menggunakan **Flutter 3.16.9** memberikan pengalaman pengembangan yang lebih stabil.

---

## 🔧 Manajemen Versi Flutter (FVM)

Project ini menggunakan **FVM (Flutter Version Management)** untuk mengunci versi Flutter yang digunakan.

### Versi Flutter yang Dibutuhkan

3.16.9

Versi ini telah didefinisikan pada file:

```
.fvmrc
```

---

## ⚙️ Instalasi FVM (Jika Belum Terpasang)

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

## 🎯 Tujuan Project

Project ini dibuat sebagai bagian dari pembelajaran pengembangan aplikasi menggunakan **Flutter** serta implementasi **database lokal dengan Isar** untuk manajemen data secara efisien.

Aplikasi ini ditujukan untuk membantu pengelolaan **absensi siswa pada jurusan RPL** secara sederhana dan terstruktur.
