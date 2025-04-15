import 'package:fitness_app/presentation/auth/sign_up/view/activity/activity_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_radio.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../generated/l10n.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';

class EditProfileActivityScreen extends StatefulWidget {
  const EditProfileActivityScreen({super.key});

  @override
  _EditProfileActivityScreenState createState() =>
      _EditProfileActivityScreenState();
}

class _EditProfileActivityScreenState extends State<EditProfileActivityScreen> {
  final ValueNotifier<String?> _selectedActivityLevel =
      ValueNotifier<String?>(null);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadActivityLevel();
  }

  Future<void> _loadActivityLevel() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // First try to get the current activity from preferences
      final currentActivity = prefs.getString('current_activity');

      if (currentActivity != null) {
        final activityKey =
            ActivityConstants.getReverseActivityMap()[currentActivity] ??
                'level1';
        _selectedActivityLevel.value = activityKey;
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // If not found in preferences, get from profile data
      final profileCubit = context.read<ProfileCubit>();
      final state = profileCubit.state;

      if (state is GetUserDataSuccessState && state.user != null) {
        _selectedActivityLevel.value = state.user?.activityLevel ?? 'level1';
        setState(() {
          _isLoading = false;
        });
        return;
      }

      await profileCubit.getUserData();
      await Future.delayed(Duration(milliseconds: 300));

      final newState = profileCubit.state;
      if (newState is GetUserDataSuccessState && newState.user != null) {
        _selectedActivityLevel.value = newState.user?.activityLevel ?? 'level1';
      } else {
        _selectedActivityLevel.value = 'level1'; // Default fallback
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading activity level: $e");
      _selectedActivityLevel.value = 'level1'; // Default fallback
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _selectedActivityLevel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (_selectedActivityLevel.value != null) {
          await _saveSelectedActivity();
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
        blurStartPosition: MediaQuery.of(context).size.height * 0.33,
        child: _isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.kOrange))
            : _buildContent(context, local),
      ),
    );
  }

  Widget _buildContent(BuildContext context, S local) {
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
                  if (_selectedActivityLevel.value != null) {
                    await _saveSelectedActivity();
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
          25.verticalSpace,
          Text(
            local.your_regular_physical_activity_level,
            style: AppFonts.font20WhiteWeight800,
            textAlign: TextAlign.start,
          ),
          65.verticalSpace,
          ValueListenableBuilder<String?>(
            valueListenable: _selectedActivityLevel,
            builder: (context, selectedValue, child) {
              return Column(
                children: [
                  CustomRadioButton(
                    label: local.level1,
                    value: "level1",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      _selectedActivityLevel.value = value;
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level2,
                    value: "level2",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      _selectedActivityLevel.value = value;
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level3,
                    value: "level3",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      _selectedActivityLevel.value = value;
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level4,
                    value: "level4",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      _selectedActivityLevel.value = value;
                    },
                  ),
                  16.verticalSpace,
                  CustomRadioButton(
                    label: local.level5,
                    value: "level5",
                    groupValue: selectedValue,
                    onChanged: (value) {
                      _selectedActivityLevel.value = value;
                    },
                  ),
                ],
              );
            },
          ),
          20.verticalSpace,
          ValueListenableBuilder<String?>(
            valueListenable: _selectedActivityLevel,
            builder: (context, selectedValue, child) {
              return SizedBox(
                width: double.infinity,
                child: CustomButton(
                  color: AppColors.kOrange,
                  onPressed: selectedValue != null
                      ? () async {
                          await _saveSelectedActivity();
                          Navigator.pop(context);
                        }
                      : null,
                  child: Text(
                    local.done,
                    style: AppFonts.font14LightWhiteWeight500,
                  ),
                ),
              );
            },
          ),
          20.verticalSpace
        ],
      ),
    );
  }

  Future<void> _saveSelectedActivity() async {
    if (_selectedActivityLevel.value != null) {
      final displayActivity =
          ActivityConstants.activityMap[_selectedActivityLevel.value!] ??
              'Rookie';
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('edit_profile_activity', displayActivity);
    }
  }
}
