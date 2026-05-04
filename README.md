# 📚 PresentApp

A modern **Classroom Attendance Application** built with **Flutter** and **Drift Database** to help manage student attendance in a **fast, lightweight, and efficient** way.

PresentApp is designed to simplify attendance recording, monthly recap management, and attendance report exports for schools, teachers, and classroom administrators.

---

## ✨ Preview

<div align="left">
  <video src="https://github.com/user-attachments/assets/8cdf9258-bbf3-4f2a-aa84-dc78d930eddc" width="320" autoplay loop muted playsinline>
  </video>
</div>

---

## 🚀 Tech Stack

| Technology | Description |
|------------|-------------|
| Flutter | Cross-platform UI framework |
| Riverpod | Modern state management |
| Drift | Local SQLite database |
| Dart | Main programming language |

---

## 🎯 Main Features

### 📌 Attendance Management
- ✅ Student attendance input per class
- ✅ Daily attendance history
- ✅ Delete attendance data
- ✅ Pull to refresh attendance page

### 📊 Recap & Reports
- ✅ Monthly attendance recap per student
- ✅ Export recap data to Excel
- ✅ Export history shown in UI

### 🎨 User Experience
- ✅ Modern UI with SliverAppBar
- ✅ Fast local database performance
- ✅ Smooth state management using Riverpod

---

## 🆕 What's New in v2.1.0

### ✨ Added
- Delete attendance data feature
- RefreshIndicator for faster data sync

### 🐞 Fixed
- Fixed monthly recap not updating instantly
- Fixed minor UI issues
- Fixed some data refresh bugs

### ⚡ Improved
- Better code structure
- Performance optimization
- Cleaner provider logic

---

## 📁 Project Structure

```text
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
│   ├── export/
│   ├── home/
│   ├── school_classes/
│   └── students/
│
├── widgets/
└── main.dart
