import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/images/app_images.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return buildCardWidget("Exercises That Strengthen Your Chest", AppImages.runningImage);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 15.w);
        },
      ),
    );
  }
}

Widget buildCardWidget(String title, String imagePath) {
  return Container(
    width: 180.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            imagePath,
            width: 180.w,
            height: 150.h,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTag("24 Tasks",isOrange: true),
                  _buildTag("Beginner", ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTag(String text, {bool isOrange = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
    decoration: BoxDecoration(
      color: AppColors.kMainColor.withOpacity(0.9),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text(
      text,
      style: AppFonts.font12OrangeWeight400.copyWith(
        color: isOrange ? AppColors.kWhite : AppColors.kOrange,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
