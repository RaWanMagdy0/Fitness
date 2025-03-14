import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.kOrange : AppColors.kLighterGrey,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: AppFonts.font14WhiteWeight400.copyWith(
            color: isSelected ? AppColors.kWhite : AppColors.kLightGrey,
          ),
        ),
      ),
    );
  }
}