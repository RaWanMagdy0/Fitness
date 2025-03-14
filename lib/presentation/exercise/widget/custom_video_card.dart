import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/fonts/app_fonts.dart';

class CustomVideoCard extends StatelessWidget {
  final Map<String, String> exercise;
  const CustomVideoCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                exercise["image"]!,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise["title"]!,
                    style: AppFonts.font14GreyWeight400,
                  ),
                  5.verticalSpace,
                  Text(exercise["sets"]!, style: AppFonts.font14GreyWeight400),
                  Text(exercise["description"]!, style: AppFonts.font14GreyWeight400),
                ],
              ),
            ),
            Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: AppColors.kOrange,
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(25.r),
                child: Center(
                  child: Icon(Icons.play_arrow, color: Colors.black, size: 30.sp),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}