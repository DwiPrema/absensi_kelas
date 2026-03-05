import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:flutter/material.dart';

class CalenderStyle {
  static List<BoxShadow> getBoxShadow(DayType type) {
    switch (type) {
      case DayType.past:
        return [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            offset: const Offset(-3, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ];
      case DayType.future:
        return [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            offset: const Offset(3, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ];
      case DayType.today:
        return [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            offset: const Offset(0, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ];
    }
  }

  static Color getCardColor(DayType type) {
    switch (type) {
      case DayType.today:
        return AppColors.yellow;
      case DayType.past:
        return Colors.white;
      case DayType.future:
        return Colors.white;
    }
  }

  static Color getTextColor(DayType type) {
    switch (type) {
      case DayType.today:
        return Colors.white;
      case DayType.past:
        return AppColors.yellow;
      case DayType.future:
        return AppColors.yellow;
    }
  }
}