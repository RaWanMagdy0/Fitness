import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';

class CustomGenderContainer extends StatelessWidget {
  const CustomGenderContainer({super.key, required this.image, required this.text,required this.selected,required this.onTap});
  final String image;
  final String text;
  final bool selected;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 110.h,
          width: 110.w,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kLighterGrey),
            color:selected? AppColors.kOrange:Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image, fit: BoxFit.contain),
                10.verticalSpace,
                Text(text, style: AppFonts.font14WhiteWeight800),
              ],
            ),
          ),
        ),
      ),
    );
  }
}