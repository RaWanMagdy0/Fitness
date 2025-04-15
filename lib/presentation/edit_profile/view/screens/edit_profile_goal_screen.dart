import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:fitness_app/core/utils/widget/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../generated/l10n.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';

class EditProfileGoalScreen extends StatefulWidget {
  const EditProfileGoalScreen({super.key});

  @override
  State<EditProfileGoalScreen> createState() => _EditProfileGoalScreenState();
}

class _EditProfileGoalScreenState extends State<EditProfileGoalScreen> {
  final ValueNotifier<String?> _selectedGoal = ValueNotifier<String?>(null);
  bool isLoading = true;

  final Map<String, String> _goalMap = {
    'gain_weight': 'Gain Weight',
    'lose_weight': 'Lose Weight',
    'get_fitter': 'Get Fitter',
    'gain_flexible': 'Gain More Flexible',
    'learn_basic': 'Learn The Basics'
  };

  late final Map<String, String> _reverseGoalMap;

  @override
  void initState() {
    super.initState();
    _reverseGoalMap =
        Map.fromEntries(_goalMap.entries.map((e) => MapEntry(e.value, e.key)));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentGoal = prefs.getString('current_goal');

      if (currentGoal != null) {
        final goalKey = _reverseGoalMap[currentGoal] ?? 'gain_weight';
        _selectedGoal.value = goalKey;
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Get goal from profile data
      final profileCubit = getIt<ProfileCubit>();
      final state = profileCubit.state;

      if (state is GetUserDataSuccessState && state.user != null) {
        _selectedGoal.value = state.user?.goal ?? 'gain_weight';
        setState(() {
          isLoading = false;
        });
        return;
      }

      await profileCubit.getUserData();
      await Future.delayed(const Duration(milliseconds: 300));

      final newState = profileCubit.state;
      if (newState is GetUserDataSuccessState && newState.user != null) {
        _selectedGoal.value = newState.user?.goal ?? 'gain_weight';
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Default fallback
      setState(() {
        _selectedGoal.value = 'gain_weight';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        _selectedGoal.value = 'gain_weight';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _selectedGoal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (_selectedGoal.value != null) {
          final displayGoal = _goalMap[_selectedGoal.value!] ?? 'Gain Weight';
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('edit_profile_goal', displayGoal);
        }
        return true;
      },
      child: CustomScaffold(
        backgroundImage: AppImages.authBackground,
        enableBlur: true,
        blurStrength: 5.0,
        blurHeight: 400.0.h,
        blurWidth: 370.0.w,
        borderRadius: 50.0.r,
        blurStartPosition: MediaQuery.of(context).size.height * 0.33,
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.kOrange))
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (_selectedGoal.value != null) {
                        final displayGoal =
                            _goalMap[_selectedGoal.value!] ??
                                'Gain Weight';
                        final prefs =
                        await SharedPreferences.getInstance();
                        await prefs.setString(
                            'edit_profile_goal', displayGoal);
                      }
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppImages.back,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              105.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    local.what_is_your_goal,
                    style: AppFonts.font20WhiteWeight800.copyWith(
                      fontSize: 20.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  5.verticalSpace,
                  Text(
                    local.this_helps_us_create_Your_personalized_plan,
                    style: AppFonts.font18WhiteWeight400.copyWith(
                      fontSize: 15.sp,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              65.verticalSpace,
              ValueListenableBuilder<String?>(
                valueListenable: _selectedGoal,
                builder: (context, selectedValue, child) {
                  return Center(
                    child: Column(
                      children: [
                        _buildRadioButton(
                          context,
                          label: local.gain_weight,
                          value: "gain_weight",
                          selectedValue: selectedValue,
                        ),
                        16.verticalSpace,
                        _buildRadioButton(
                          context,
                          label: local.lose_weight,
                          value: "lose_weight",
                          selectedValue: selectedValue,
                        ),
                        16.verticalSpace,
                        _buildRadioButton(
                          context,
                          label: local.get_fitter,
                          value: "get_fitter",
                          selectedValue: selectedValue,
                        ),
                        16.verticalSpace,
                        _buildRadioButton(
                          context,
                          label: local.gain_more_flexible,
                          value: "gain_flexible",
                          selectedValue: selectedValue,
                        ),
                        16.verticalSpace,
                        _buildRadioButton(
                          context,
                          label: local.learn_the_basics,
                          value: "learn_basic",
                          selectedValue: selectedValue,
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
                    height: 50.h,
                    child: CustomButton(
                      color: AppColors.kOrange,
                      onPressed: selectedValue != null
                          ? () async {
                        final displayGoal =
                            _goalMap[selectedValue] ??
                                'Gain Weight';
                        final prefs =
                        await SharedPreferences.getInstance();
                        await prefs.setString(
                            'edit_profile_goal', displayGoal);
                        Navigator.pop(context);
                      }
                          : null,
                      child: Text(
                        local.done,
                        style:
                        AppFonts.font14LightWhiteWeight500.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButton(
      BuildContext context, {
        required String label,
        required String value,
        required String? selectedValue,
      }) {
    return CustomRadioButton(
      label: label,
      value: value,
      groupValue: selectedValue,
      onChanged: (value) {
        _selectedGoal.value = value;
      },
    );
  }
}