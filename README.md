# 📚 Classroom Attendance App

A **Classroom Attendance** application built with **Flutter** and **Isar Database** to help record student attendance in a **fast, lightweight, and efficient** way.

This project is an **initial stable release**, focusing on implementing simple yet powerful core attendance features.

---

## ✨ Preview

<div align="left">
  <video src="https://github.com/user-attachments/assets/8cdf9258-bbf3-4f2a-aa84-dc78d930eddc" width="320" autoplay loop muted playsinline>
  </video>
</div>

---

## 🚀 Tech Stack

| Technology | Description                     |
| ---------- | ------------------------------- |
| Flutter    | Cross-platform UI framework     |
| Riverpod   | Modern state management         |
| Isar       | Super fast local NoSQL database |
| Dart       | Main programming language       |

---

## 🎯 Main Features

* ✅ Student attendance input per class
* ✅ Daily attendance history
* ✅ Monthly attendance recap per student
* ✅ Sorting based on attendance number
* ✅ Modern UI using Sliver

---

## 📌 Why Use Flutter 3.16.9?

This project uses this version to maintain development stability:

* ✅ Compatible with **Isar 3.x**
* ✅ Avoids Android Gradle Plugin (AGP) issues
* ✅ Avoids breaking changes in newer versions
* ✅ More stable for long-term development

> ⚠️ Isar is not fully compatible with the latest Flutter versions at the time this project was created.

---

## 🔧 Flutter Version Management (FVM)

This project uses **FVM (Flutter Version Management)** to ensure Flutter version consistency.

### 📌 Required Version

```
Flutter 3.16.9
```

This version is locked in the file:

```
.fvmrc
```

---

## ⚙️ Install FVM

If you don’t have FVM yet:

```bash
dart pub global activate fvm
```

---

## 📦 Project Setup

```bash
fvm install
fvm use
fvm flutter pub get
```

---

## ▶️ Run the App

```bash
fvm flutter run
```

---

## 📁 Project Structure (Simplified)

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

## 🎯 Project Goals

This project was created for:

* 📚 School assignment & learning media for Flutter & Riverpod
* 🧠 Implementation of a local database using Isar
* 💼 Mobile app development portfolio
* 🚀 Helping classroom devices / teachers in schools to record and recap student attendance

---

## 📦 Download & Release

This application has reached a stable stage for its core features. You can try the app directly by downloading the APK file on the **Releases** page.

### **Latest Version: [v1.0.0 - Initial Release](https://www.google.com/search?q=https://github.com/DwiPrema/absensi_kelas/releases/tag/v1.0.0)**

> **Note:** Choose the APK file that matches your device architecture (recommended **arm64-v8a** for modern smartphones).

---

## 🚀 Future Improvements (Roadmap to v2.0.0)

The development plan for the next version will focus on efficiency and smart technologies:

* 🤖 **AI Assistant Integration:** Implementation of an intelligent assistant (Gemini API) for automatic recap and student attendance data analysis.
* 🛠️ **Database Refactor:** Optimization of the database schema structure for better performance and scalability.
* 📊 **Enhanced Analytics:** Visualization of attendance statistics in interactive charts/graphs.
* 📤 **Export Data:** Feature to export attendance reports to PDF or Excel format.

---

## ⭐ Support

If this project helps you, don’t forget to:

* ⭐ **Star** this repository
* 🍴 **Fork** the project for further development
* 💬 Give feedback or suggestions through **Issues**

---
