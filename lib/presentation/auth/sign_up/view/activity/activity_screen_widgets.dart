import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/local/sign_up_provider.dart';
import '../../../../../core/routes/page_route_name.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/styles/fonts/app_fonts.dart';
import '../../../../../core/styles/images/app_images.dart';
import '../../../../../core/utils/widget/custom_button.dart';
import '../../../../../core/utils/widget/custom_radio.dart';
import '../../../../../core/utils/widget/custom scaffold.dart';
import '../../../../../data/models/sign_up/request/sign_up_request_body.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/sign_up_cubit.dart';
import '../../widgets/custom_indecator.dart';
import 'activity_constants.dart';
import 'activity_screen_state.dart';

class ActivityScreenWidgets {
  static Widget buildContent(BuildContext context, ActivityScreenState state,
      S local, SignupProvider signupProvider) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          40.verticalSpace,
          Row(
            children: [
              InkWell(
                onTap: () async {
                  if (state.isFromEditProfile &&
                      state.selectedActivityLevel.value != null) {
                    final displayActivity = ActivityConstants
                            .activityMap[state.selectedActivityLevel.value!] ??
                        'Rookie';
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        'edit_profile_activity', displayActivity);
                  }
                  Navigator.pop(context);
                },
                child: Image.asset(AppImages.back),
              ),
              100.horizontalSpace,
              Image.asset(AppImages.logoIcon),
            ],
          ),
          50.verticalSpace,
          if (!state.isFromEditProfile)
            Center(
                child: ProgressIndicatorWidget(currentPage: 6, totalPages: 6)),
          25.verticalSpace,
          Text(
            local.your_regular_physical_activity_level,
            style: AppFonts.font20WhiteWeight800,
            textAlign: TextAlign.start,
          ),
          65.verticalSpace,
          ValueListenableBuilder<String?>(
            valueListenable: state.selectedActivityLevel,
            builder: (context, selectedValue, child) {
              return Column(
                children: [
                  CustomRadioButton(
                    label: local.level1,
                    value: "level1",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      state.selectedActivityLevel.value = value;
                      if (!state.isFromEditProfile) {
                        signupProvider.saveData("activityLevel", value);
                      }
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level2,
                    value: "level2",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      state.selectedActivityLevel.value = value;
                      if (!state.isFromEditProfile) {
                        signupProvider.saveData("activityLevel", value);
                      }
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level3,
                    value: "level3",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      state.selectedActivityLevel.value = value;
                      if (!state.isFromEditProfile) {
                        signupProvider.saveData("activityLevel", value);
                      }
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level4,
                    value: "level4",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      state.selectedActivityLevel.value = value;
                      if (!state.isFromEditProfile) {
                        signupProvider.saveData("activityLevel", value);
                      }
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level5,
                    value: "level5",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      state.selectedActivityLevel.value = value;
                      if (!state.isFromEditProfile) {
                        signupProvider.saveData("activityLevel", value);
                      }
                    },
                  ),
                ],
              );
            },
          ),
          20.verticalSpace,
          ValueListenableBuilder<String?>(
            valueListenable: state.selectedActivityLevel,
            builder: (context, selectedValue, child) {
              return SizedBox(
                width: double.infinity,
                child: CustomButton(
                  color: AppColors.kOrange,
                  onPressed: selectedValue != null
                      ? () async {
                          if (state.isFromEditProfile) {
                            final displayActivity =
                                ActivityConstants.activityMap[selectedValue] ??
                                    'Rookie';
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString(
                                'edit_profile_activity', displayActivity);
                            Navigator.pop(context);
                          } else {
                            try {
                              final signUpCubit = context.read<SignUpCubit>();
                              signupProvider.saveData(
                                  "activityLevel", selectedValue);

                              final requestBody = SignupRequestBody(
                                firstName: signupProvider.getData("firstName"),
                                lastName: signupProvider.getData("lastName"),
                                email: signupProvider.getData("email"),
                                password: signupProvider.getData("password"),
                                rePassword:
                                    signupProvider.getData("rePassword"),
                                height: int.tryParse(
                                        signupProvider.getData("height") ??
                                            '') ??
                                    0,
                                weight: int.tryParse(
                                        signupProvider.getData("weight") ??
                                            '') ??
                                    0,
                                age: int.tryParse(
                                        signupProvider.getData("age") ?? '') ??
                                    0,
                                gender: signupProvider.getData("gender"),
                                goal: signupProvider.getData("goal"),
                                activityLevel: selectedValue,
                              );
                              signUpCubit.signUp(requestBody);
                            } catch (e) {
                              Navigator.pushNamed(
                                  context, PageRouteName.mainSignUp);
                            }
                          }
                        }
                      : null,
                  child: Text(
                    state.isFromEditProfile ? local.done : local.next,
                    style: AppFonts.font14LightWhiteWeight500,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget buildScaffold(
      BuildContext context, Widget content, bool isFromEditProfile) {
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 385.0,
      blurWidth: 370.0.w,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.38,
      child: content,
    );
  }
}
