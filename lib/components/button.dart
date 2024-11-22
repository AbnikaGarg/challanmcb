import 'package:challanmcbjava/util/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String? title1;
  const CustomButton({super.key, required this.title1});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: Get.width * .9,
      decoration: BoxDecoration(
        color: AppColors.maincolor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.5,
              offset: Offset(0, 0),
            )
          ]),
      child: Text(title1!,
          style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteBackgroundColor)),
    );
  }
}
