import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/di.dart';
import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_radio.dart';
import '../../../../generated/l10n.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';
import '../widgets/custom_indecator.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final ValueNotifier<String?> _selectedGoal = ValueNotifier<String?>(null);
  bool isFromEditProfile = false;
  bool isLoading = true;

  // Map between displayed values and stored values
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
    _reverseGoalMap = Map.fromEntries(_goalMap.entries.map((e) => MapEntry(e.value, e.key)));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSourceAndLoadData();
    });
  }

  Future<void> _checkSourceAndLoadData() async {
    try {
      final signupProvider = context.read<SignupProvider>();
      final prefs = await SharedPreferences.getInstance();
      final currentGoal = prefs.getString('current_goal');

      if (currentGoal != null) {
        // Coming from edit profile
        isFromEditProfile = true;
        final goalKey = _reverseGoalMap[currentGoal] ?? 'gain_weight';
        _selectedGoal.value = goalKey;
        setState(() {
          isLoading = false;
        });
        return;
      }

      final route = ModalRoute.of(context);
      if (route != null && route.settings.name != PageRouteName.goalScreen) {
        final profileCubit = getIt<ProfileCubit>();
        final state = profileCubit.state;

        if (state is GetUserDataSuccessState && state.user != null) {
          isFromEditProfile = true;
          _selectedGoal.value = state.user?.goal ?? 'gain_weight';
          setState(() {
            isLoading = false;
          });
          return;
        }

        await profileCubit.getUserData();
        await Future.delayed(Duration(milliseconds: 300));

        final newState = profileCubit.state;
        if (newState is GetUserDataSuccessState && newState.user != null) {
          isFromEditProfile = true;
          _selectedGoal.value = newState.user?.goal ?? 'gain_weight';
          setState(() {
            isLoading = false;
          });
          return;
        }
      }

      _selectedGoal.value = signupProvider.getData("goal");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error loading goal data: $e");
      setState(() {
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
    final signupProvider = context.read<SignupProvider>();

    return WillPopScope(
      onWillPop: () async {
        if (isFromEditProfile && _selectedGoal.value != null) {
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
        blurHeight: 385.0,
        blurWidth: 370.0.w,
        borderRadius: 50.0,
        blurStartPosition: MediaQuery.of(context).size.height * 0.38,
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
                      if (isFromEditProfile && _selectedGoal.value != null) {
                        final displayGoal = _goalMap[_selectedGoal.value!] ?? 'Gain Weight';
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('edit_profile_goal', displayGoal);
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
              if (!isFromEditProfile)
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
                            if (!isFromEditProfile) {
                              signupProvider.saveData("goal", value);
                            }
                          },
                        ),
                        16.verticalSpace,
                        CustomRadioButton(
                          label: local.lose_weight,
                          value: "lose_weight",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            _selectedGoal.value = value;
                            if (!isFromEditProfile) {
                              signupProvider.saveData("goal", value);
                            }
                          },
                        ),
                        16.verticalSpace,
                        CustomRadioButton(
                          label: local.get_fitter,
                          value: "get_fitter",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            _selectedGoal.value = value;
                            if (!isFromEditProfile) {
                              signupProvider.saveData("goal", value);
                            }
                          },
                        ),
                        16.verticalSpace,
                        CustomRadioButton(
                          label: local.gain_more_flexible,
                          value: "gain_flexible",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            _selectedGoal.value = value;
                            if (!isFromEditProfile) {
                              signupProvider.saveData("goal", value);
                            }
                          },
                        ),
                        16.verticalSpace,
                        CustomRadioButton(
                          label: local.learn_the_basics,
                          value: "learn_basic",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            _selectedGoal.value = value;
                            if (!isFromEditProfile) {
                              signupProvider.saveData("goal", value);
                            }
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
                          ? () async {
                        if (isFromEditProfile) {
                          final displayGoal = _goalMap[selectedValue] ?? 'Gain Weight';
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('edit_profile_goal', displayGoal);
                          Navigator.pop(context);
                        } else {
                          signupProvider.saveData("goal", selectedValue);
                          Navigator.pushReplacementNamed(
                              context, PageRouteName.activityScreen);
                        }
                      }
                          : null,
                      child: Text(
                        isFromEditProfile ? local.done : local.next,
                        style: AppFonts.font14LightWhiteWeight500,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}