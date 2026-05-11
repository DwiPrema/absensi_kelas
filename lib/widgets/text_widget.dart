import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

Widget textPagratiNarrow(
  String text, {
  TextAlign textAlign = TextAlign.left,
  Color color = AppColors.white,
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'PragatiNarrow',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget textPoppins(
  String text, {
  TextAlign textAlign = TextAlign.left,
  Color color = AppColors.white,
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
