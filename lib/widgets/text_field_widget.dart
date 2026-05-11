import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

enum TextFieldType { normal, outline }

Widget textFieldWidget({
  required String labelText,
  required TextEditingController controller,
  int? maxLength,
  String errorText = "field ini harus diisi!",
  bool alert = false,
  TextFieldType textFieldType = TextFieldType.normal,
}) {
  switch (textFieldType) {
    case TextFieldType.outline:
      return TextFormField(
        controller: controller,
        autofocus: true,
        maxLength: maxLength,
        minLines: 1,
        maxLines: null,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          errorText: alert ? errorText : null,
          labelText: labelText,
          labelStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.black,
          ),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.blueCard.withAlpha(100),
              width: 2,
            ),
          ),
        ),
      );

    case TextFieldType.normal:
      return TextFormField(
        maxLength: maxLength,
        minLines: 1,
        maxLines: null,
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          errorText: alert ? errorText : null,
          hintText: labelText,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.black.withAlpha(100),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.blueCard,
              width: 2,
            ),
          ),
        ),
      );
  }
}