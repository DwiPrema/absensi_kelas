import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/core/routes/routes.dart';
import 'package:absensi_kelas/features/attendance/ui/attendance_export.dart';
import 'package:absensi_kelas/features/attendance/ui/attendance_history.dart';
import 'package:absensi_kelas/features/attendance/ui/attendance_page.dart';
import 'package:absensi_kelas/features/attendance/ui/attendance_recap.dart';
import 'package:absensi_kelas/features/attendance/ui/attendance_result_page.dart';
import 'package:absensi_kelas/features/students/ui/student_page.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>? ?? {};

    switch (settings.name) {
      //Routes to Student Page
      case AppRoutes.studentPage:
        final schoolClass = args['schoolClass'] as SchoolClassesData;
        final mainColor = args['mainColor'] as Color;

        return MaterialPageRoute(
          builder: (_) =>
              StudentPage(mainColor: mainColor, schoolClass: schoolClass),
        );

      //Routes to Attendance Page
      case AppRoutes.attendancePage:
        final headerColor = args['headerColor'] as Color;
        final gradientColor = args['gradientColor'] as Color;
        final schoolClassId = args['schoolClassId'] as int;
        final schoolClassName = args['schoolClassName'] as String;

        return MaterialPageRoute(
          builder: (_) => AttendancePage(
            headerColor: headerColor,
            gradientHeaderColor: gradientColor,
            schoolClassId: schoolClassId,
            schoolClassName: schoolClassName,
          ),
        );

      //Routes to Attendance Result Page
      case AppRoutes.attendanceResultPage:
        final date = args["date"] as DateTime;
        final schoolClassId = args['schoolClassId'] as int;
        final attendanceId = args['attendanceId'] as int;
        final schoolClassName = args['schoolClassName'] as String;
        final totalStudents = args['totalStudent'] as String;

        return MaterialPageRoute(
          builder: (_) => ResultAttendancePage(
            schoolClassId: schoolClassId,
            schoolClassName: schoolClassName,
            totalStudent: totalStudents,
            attendanceId: attendanceId,
            dateTime: date,
          ),
        );

      //Routes to Attendance History Page
      case AppRoutes.attendanceHistoryPage:
        final schoolClassId = args['schoolClassId'] as int;
        final schoolClassName = args['schoolClassName'] as String;
        final totalStudents = args['totalStudent'] as String;
        final mainColor = args['mainColor'] as Color;

        return MaterialPageRoute(
          builder: (_) => AttendanceHistoryPage(
            className: schoolClassName,
            classId: schoolClassId,
            mainColor: mainColor,
            totalStudent: totalStudents,
          ),
        );

      //Routes to Attendance Recap Page
      case AppRoutes.attendanceRecapPage:
        final recap = args['recap'] as Map<int, Map<StatusKehadiran, int>>;
        final students = args['students'] as List<Student>;
        final month = args['month'] as String;
        final schoolClassName = args['schoolClassName'] as String;
        final mainColor = args['mainColor'] as Color;

        return MaterialPageRoute(
          builder: (_) => MonthlyStudentRecap(
            recap: recap,
            students: students,
            className: schoolClassName,
            month: month,
            mainColor: mainColor,
          ),
        );

      //Routes to Export History Page
      case AppRoutes.exportHistoryPage:
        return MaterialPageRoute(builder: (_) => ExportHistoryPage());

      //Default Routes (Page Not Found)
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: textPoppins("Page Not Found", color: AppColors.black),
            ),
          ),
        );
    }
  }
}
