import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InfoButton extends StatelessWidget {
  final String text;
  const InfoButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(60.w, 20.h),
        backgroundColor: AppColors.kOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
      onPressed: () {},
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
    );
  }
}
