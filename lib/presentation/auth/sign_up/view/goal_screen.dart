import 'package:fitness_app/core/generated/l10n.dart';
import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:fitness_app/core/utils/widget/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../generated/l10n.dart';
import '../widgets/custom_indecator.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final ValueNotifier<String?> _selectedGoal = ValueNotifier<String?>(null);
  @override
  void initState() {
    super.initState();
    final signupProvider = context.read<SignupProvider>();
    _selectedGoal.value = signupProvider.getData("goal");
  }

  @override
  void dispose() {
    _selectedGoal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final local = S.of(context);
    final signupProvider = context.read<SignupProvider>();
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 385.0,
      blurWidth: 370.0.w,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.38,
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
                    Navigator.pushNamed(context, PageRouteName.heightScreen);
                  },
                  child: Image.asset(AppImages.back),
                ),
                100.horizontalSpace,
                Image.asset(AppImages.logoIcon),
              ],
            ),
            50.verticalSpace,
            Center(
                child: ProgressIndicatorWidget(currentPage: 5, totalPages: 6)),
            25.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.what_is_your_goal,
                  style: AppFonts.font20WhiteWeight800,
                  textAlign: TextAlign.start,
                ),
                5.verticalSpace,
                Text(
                 local.this_helps_us_create_Your_personalized_plan,
                  style:
                      AppFonts.font18WhiteWeight400.copyWith(fontSize: 15.sp),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            38.verticalSpace,
            ValueListenableBuilder<String?>(
              valueListenable: _selectedGoal,
              builder: (context, selectedValue, child) {
                return Center(
                  child: Column(
                    children: [
                      CustomRadioButton(
                        label: local.gain_weight,
                        value: "gain_weight",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedGoal.value = value;
                          signupProvider.saveData("goal", value);
                        },
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: local.lose_weight,
                        value: "lose_weight",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedGoal.value = value;
                          signupProvider.saveData("goal", value);
                        },
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: local.get_fitter,
                        value: "get_fitter",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedGoal.value = value;
                          signupProvider.saveData("goal", value);
                        },
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: local.gain_more_flexible,
                        value: "gain_flexible",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedGoal.value = value;
                          signupProvider.saveData("goal", value);
                        },
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: local.learn_the_basics,
                        value: "learn_basic",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedGoal.value = value;
                          signupProvider.saveData("goal", value);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            20.verticalSpace,
            ValueListenableBuilder<String?>(
              valueListenable: _selectedGoal,
              builder: (context, selectedValue, child) {
                return SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    color: AppColors.kOrange,
                    onPressed: selectedValue != null
                        ? () {
                            signupProvider.saveData("goal", selectedValue);
                            Navigator.pushReplacementNamed(
                                context, PageRouteName.activityScreen);
                          }
                        : null,
                    child: Text(
                      local.next,
                      style: AppFonts.font14LightWhiteWeight500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
