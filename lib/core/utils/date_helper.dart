class DateHelper {
  static DateTime todayOnly() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}