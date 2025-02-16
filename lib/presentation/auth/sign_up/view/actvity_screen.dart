import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/const/app_string.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:fitness_app/core/utils/widget/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widget/custom scaffold.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ValueNotifier<String?> _selectedActivityLevel =
      ValueNotifier<String?>(null);
  double blurHeight = 380.0;

  @override
  void dispose() {
    _selectedActivityLevel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 400,
      blurWidth: 354.0,
      borderRadius: 30.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.4,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.verticalSpace,
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageRouteName.goalScreen);
                  },
                  child: Image.asset(AppImages.back),
                ),
                100.horizontalSpace,
                Image.asset(AppImages.logoIcon),
              ],
            ),

            80.verticalSpace,

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.kOrange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "6/6",
                  style: AppFonts.font16WhiteWeight500,
                ),
              ),
            ),

            16.verticalSpace,

            Text(
              AppStrings.yourRegular,
              style: AppFonts.font20WhiteWeight800,
              textAlign: TextAlign.start,
            ),

            32.verticalSpace,

            ValueListenableBuilder<String?>(
              valueListenable: _selectedActivityLevel,
              builder: (context, selectedValue, child) {
                return Column(
                  children: [
                    CustomRadioButton(
                      label: "Rookie",
                      value: "rookie",
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          _selectedActivityLevel.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "Beginner",
                      value: "beginner",
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          _selectedActivityLevel.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "Intermediate",
                      value: "intermediate",
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          _selectedActivityLevel.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "Advance",
                      value: "advance",
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          _selectedActivityLevel.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "True Beast",
                      value: "true_beast",
                      groupValue: selectedValue,
                      onChanged: (value) =>
                          _selectedActivityLevel.value = value,
                    ),
                  ],
                );
              },
            ),
            40.verticalSpace,
            ValueListenableBuilder<String?>(
              valueListenable: _selectedActivityLevel,
              builder: (context, selectedValue, child) {
                return SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    color: AppColors.kOrange,
                    onPressed: selectedValue != null
                        ? () {
                            Navigator.pushReplacementNamed(
                                context, PageRouteName.genderSignUp);
                          }
                        : null,
                    child: Text(
                      AppStrings.next,
                      style: AppFonts.font14LightWhiteWeight500,
                    ),
                  ),
                );
              },
            ),

            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
