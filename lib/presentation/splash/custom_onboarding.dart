import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/styles/fonts/app_fonts.dart';
import '../../core/styles/images/app_images.dart';
import 'dots_Indicator.dart';

class CustomOnboarding extends StatelessWidget {
  final String iconPath;
  final String mainText;
  final String subText;
  final VoidCallback next;
  final VoidCallback? back;
  final VoidCallback skip;
  final bool showBack;
  final int position;

  const CustomOnboarding({
    Key? key,
    required this.iconPath,
    required this.mainText,
    required this.subText,
    required this.next,
    this.back,
    required this.skip,
    this.showBack = true,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 350.0,
      blurWidth: 370.0,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.65,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            50.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBack && back != null)
                  InkWell(
                    onTap: back,
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                InkWell(
                  onTap: skip,
                  child: Text("SKIP", style: AppFonts.font14GreyWeight400),
                ),
              ],
            ),
            Image.asset(iconPath),
            Text(
              mainText,
              style: AppFonts.font24WhiteWeight800,
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            Text(
              subText,
              style: AppFonts.font16GreyWeight400,
              textAlign: TextAlign.center,
            ),
            15.verticalSpace,
            DotsIndicator(
              dotsCount: 3,
              currentPosition: position,
            ),
            15.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showBack && back != null)
                    SizedBox(
                      width: 100.w,
                      child: CustomButton(
                        onPressed: back,
                        text: "Back",
                        color: Colors.transparent,
                        borderColor: AppColors.kOrange,
                      ),
                    ),
                  SizedBox(
                    width: 100.w,
                    child: CustomButton(
                      onPressed: next,
                      text: "Next",
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }}