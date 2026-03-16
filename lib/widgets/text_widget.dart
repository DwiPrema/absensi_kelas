import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    style: GoogleFonts.pragatiNarrow(
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
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}


// Widget textInriaSans(
//   String text, {
//   TextAlign textAlign = TextAlign.left,
//   Color color = AppColors.white,
//   double fontSize = 12,
//   FontWeight fontWeight = FontWeight.w400,
// }) {
//   return Text(
//     text,
//     textAlign: textAlign,
//     style: GoogleFonts.inriaSans(
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       color: color,
//     ),
//   );
// }