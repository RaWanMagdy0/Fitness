import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/fonts/app_fonts.dart';

class CustomProfileField extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const CustomProfileField({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$title ',
              style: AppFonts.font14WhiteWeight400,
            ),
            Text(
              '(',
              style: AppFonts.font14WhiteWeight400,
            ),
            Text(
              'tap To Edit',
              style: AppFonts.font14LightOrangeWeight400,
            ),
            Text(
              ')',
              style: AppFonts.font14WhiteWeight400,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Text(
              value,
              style: AppFonts.font14WhiteWeight400,
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}