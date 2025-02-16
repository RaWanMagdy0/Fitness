import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final ValueChanged<String> onChanged;

  final Color? selectedBorderColor, unselectedBorderColor;
  final Color? selectedBackgroundColor, unselectedBackgroundColor;
  final Color? selectedDotColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const CustomRadioButton({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.selectedDotColor,
    this.borderWidth,
    this.borderRadius,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: double.infinity,
        height: 45.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedBackgroundColor ??
                  AppColors.kLighterGrey.withOpacity(0.2)
              : unselectedBackgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
          border: Border.all(
            color: isSelected
                ? selectedBorderColor ?? AppColors.kLighterGrey
                : unselectedBorderColor ?? AppColors.kLighterGrey,
            width: borderWidth ?? 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// ✅ **النص (Label)**
            Expanded(
              child: Text(
                label,
                style: AppFonts.font16WhiteWeight500,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? selectedBorderColor ?? AppColors.kLighterGrey
                      : unselectedBorderColor ?? AppColors.kLighterGrey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 14.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedDotColor ?? AppColors.kLighterGrey,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
