import 'package:absensi_kelas/core/enums/enum.dart';
import 'package:absensi_kelas/features/home_page/widgets/calendar/calender_style.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CalendarCard extends StatelessWidget {
  final DateTime date;
  final double cardWidth;
  final double cardHeight;
  final double dayNameFontSize;
  final double dateFontSize;
  final DayType Function(DateTime) getDayType;
  final String Function(DateTime) getDayName;

  const CalendarCard({
    super.key,
    required this.date,
    required this.cardWidth,
    required this.cardHeight,
    required this.dayNameFontSize,
    required this.dateFontSize,
    required this.getDayType,
    required this.getDayName,
  });

  @override
  Widget build(BuildContext context) {
    final dayType = getDayType(date);

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Container(
            width: double.infinity,
            height: cardHeight * 0.85,
            decoration: BoxDecoration(
              color: CalenderStyle.getCardColor(dayType),
              borderRadius: BorderRadius.circular(60),
              boxShadow: CalenderStyle.getBoxShadow(dayType),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textPoppins(date.day.toString(), fontSize: dateFontSize, fontWeight: FontWeight.w700, color: CalenderStyle.getTextColor(dayType)),
                const SizedBox(height: 4),
                textPoppins(getDayName(date), fontSize: dayNameFontSize, fontWeight: FontWeight.w500, color: CalenderStyle.getTextColor(dayType).withAlpha(170)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}