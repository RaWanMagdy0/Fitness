import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routes/page_route_name.dart';
import '../../core/styles/colors/app_colors.dart';
import '../../core/styles/fonts/app_fonts.dart';
import '../../core/styles/images/app_images.dart';
import '../../core/utils/widget/custom scaffold.dart';
import '../../core/utils/widget/custom_button.dart';
import 'dots_Indicator.dart';

class CustomOnboarding extends StatelessWidget {
  final String iconPath;
  final String mainText;
  final String subText;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final bool showBack;
  final bool isLast;

  const CustomOnboarding({
    super.key,
    required this.iconPath,
    required this.mainText,
    required this.subText,
    required this.onNext,
    this.onBack,
    this.showBack = true,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 510.0,
      blurWidth: 370.0,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.63,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBack && onBack != null)
                  InkWell(
                    onTap: () => Navigator.pushReplacementNamed(
                        context, PageRouteName.login),
                    child: Text("SKIP", style: AppFonts.font14GreyWeight400),
                  ),
              ],
            ),
            10.verticalSpace,
            Image.asset(iconPath),
            15.verticalSpace,
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
              currentPosition: isLast ? 2 : (showBack ? 1 : 0),
            ),
            15.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBack && onBack != null)
                  SizedBox(
                    width: 100.w,
                    child: CustomButton(
                      onPressed: onBack,
                      text: "Back",
                      color: Colors.transparent,
                      borderColor: AppColors.kOrange,
                    ),
                  ),
                SizedBox(
                  width: 100.w,
                  child: CustomButton(
                    onPressed: onNext,
                    text: isLast ? "Do It" : "Next",
                  ),
                ),
              ],
            ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}
