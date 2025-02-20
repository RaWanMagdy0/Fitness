import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const CustomProfileRow({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 23.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.kOrange),
                15.horizontalSpace,
                Text(
                  title,
                  style: AppFonts.font14WhiteWeight600,)
              ],
            ),
            const Icon(Icons.arrow_forward_ios,
                color: AppColors.kOrange, size: 16),
          ],
        ),
      ),
    );
  }
}
