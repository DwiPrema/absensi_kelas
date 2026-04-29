import 'package:absensi_kelas/core/constant/app_colors.dart';
import 'package:absensi_kelas/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CardStudent extends StatelessWidget {
  final String name;
  final String rollNum;
  final String gender;
  final String? nis;
  final String? nisn;
  final Color mainColor;
  final VoidCallback onTapRemove;
  final VoidCallback onTapEdit;

  const CardStudent({
    super.key,
    required this.name,
    required this.rollNum,
    required this.gender,
    required this.nis,
    required this.nisn,
    required this.mainColor,
    required this.onTapRemove,
    required this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(40),
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: textPoppins(
                    rollNum,
                    color: AppColors.white,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    textPoppins(
                      gender,
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "NIS / NISN : ",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 8,
                            ),
                          ),
                          TextSpan(
                            text: "$nis / $nisn",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 8,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: onTapRemove,
                    child: const Icon(
                      Icons.delete,
                      size: 22,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onTapEdit,
                    child: const Icon(
                      Icons.edit_square,
                      size: 22,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
