import 'package:fitness_app/core/generated/l10n.dart';
import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/const/app_string.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart'
    show CustomScaffold;
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:fitness_app/core/utils/widget/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final ValueNotifier<String?> _selectedGoal = ValueNotifier<String?>(null);
  double blurHeight = 375.0;

  @override
  void dispose() {
    _selectedGoal.dispose(); // 🔹 تحرير الموارد عند التخلص من الصفحة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: blurHeight,
      blurWidth: 354.0,
      borderRadius: 30.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.46,
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
                    Navigator.pushNamed(context, PageRouteName.genderSignUp);
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
                  "5/6",
                  style: AppFonts.font16WhiteWeight500,
                ),
              ),
            ),
            16.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.whatGoal,
                  style: AppFonts.font20WhiteWeight800,
                  textAlign: TextAlign.start,
                ),
                8.verticalSpace,
                Text(
                  AppStrings.thisHelps,
                  style: AppFonts.font18WhiteWeight400,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            32.verticalSpace,
            ValueListenableBuilder<String?>(
              valueListenable: _selectedGoal,
              builder: (context, selectedValue, child) {
                return Column(
                  children: [
                    CustomRadioButton(
                      label: "Gain Weight",
                      value: "gain_weight",
                      groupValue: selectedValue,
                      onChanged: (value) => _selectedGoal.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "Lose Weight",
                      value: "lose_weight",
                      groupValue: selectedValue,
                      onChanged: (value) => _selectedGoal.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "Get Fitter",
                      value: "get_fitter",
                      groupValue: selectedValue,
                      onChanged: (value) => _selectedGoal.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "Gain More Flexible",
                      value: "gain_flexible",
                      groupValue: selectedValue,
                      onChanged: (value) => _selectedGoal.value = value,
                    ),
                    16.verticalSpace,
                    CustomRadioButton(
                      label: "Learn The Basic",
                      value: "learn_basic",
                      groupValue: selectedValue,
                      onChanged: (value) => _selectedGoal.value = value,
                    ),
                  ],
                );
              },
            ),
            40.verticalSpace,
            ValueListenableBuilder<String?>(
              valueListenable: _selectedGoal,
              builder: (context, selectedValue, child) {
                return SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    color: AppColors.kOrange,
                    onPressed: selectedValue != null
                        ? () {
                            Navigator.pushReplacementNamed(
                                context, PageRouteName.actvityScreen);
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
