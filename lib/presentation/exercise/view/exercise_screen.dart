import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/widget/custom_arrow.dart';
import '../widget/tab_bar_section.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage:AppImages.homeBackG,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 350.h,
                child: Image.asset(
                  AppImages.chestExerciseImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16.h,
                left: 16.w,
                child: CustomArrow(),
              ),
              Positioned(
                bottom: 0.h,
                left: 0.w,
                right: 0.w,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.kMainColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chest Exercise",
                          style: AppFonts.font24WhiteWeight600,
                          textAlign: TextAlign.center,
                        ),
                        8.verticalSpace,
                        Text(
                          "Lorem ipsum dolor sit amet consectetur. Tempus volutpat ut nisi morbi.",
                          textAlign: TextAlign.center,
                          style: AppFonts.font16WhiteWeight500,
                        ),
                        8.verticalSpace,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(18.w, 40.h),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.w,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "30 MIN" ?? '',
                                style: AppFonts.font12OrangeWeight400,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(18.w, 40.h),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.w,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "120 cal" ?? '',
                                style: AppFonts.font12OrangeWeight400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
         10.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              child: TabBarSection(),
            ),
          ),
        ],
      ),
    );
  }}