import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static DateTime todayOnly() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static String getDayName(DateTime date, String locale) {
    return DateFormat('EEE', locale).format(date).toString();
  }

  static String getDayFullName(DateTime date, String locale) {
    return DateFormat('EEEE', locale).format(date).toString();
  }

  static String getMonthName(DateTime date, String locale) {
    return DateFormat('MMMM', locale).format(date);
  }

  static DayType getDayType(DateTime date) {
    final todayDate = DateHelper.todayOnly();
    final compareDate = DateTime(date.year, date.month, date.day);
    if (compareDate.isBefore(todayDate)) return DayType.past;
    if (compareDate.isAfter(todayDate)) return DayType.future;
    return DayType.today;
  }
}