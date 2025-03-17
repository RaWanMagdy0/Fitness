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
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_radio.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../data/models/sign_up/request/sign_up_request_body.dart';
import '../../../../generated/l10n.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';
import '../view_model/sign_up_cubit.dart';
import '../widgets/custom_indecator.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ValueNotifier<String?> _selectedActivityLevel = ValueNotifier<String?>(null);
  bool isFromEditProfile = false;
  bool isLoading = true;

  // Map between displayable and stored values
  final Map<String, String> _activityMap = {
    'level1': 'Rookie',
    'level2': 'Beginner',
    'level3': 'Intermediate',
    'level4': 'Advanced',
    'level5': 'Expert'
  };

  // Reverse map for looking up keys by values
  late final Map<String, String> _reverseActivityMap;

  @override
  void initState() {
    super.initState();
    // Initialize reverse map
    _reverseActivityMap = Map.fromEntries(_activityMap.entries.map((e) => MapEntry(e.value, e.key)));

    // We need to delay this until the context is fully available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSourceAndLoadData();
    });
  }

  Future<void> _checkSourceAndLoadData() async {
    try {
      // Check the current route to determine if coming from edit profile
      final route = ModalRoute.of(context);
      final args = route?.settings.arguments;

      if (args is Map && args['isFromEdit'] == true) {
        isFromEditProfile = true;
      }

      if (route?.settings.name == 'ActivityScreenFromEdit') {
        isFromEditProfile = true;
      }

      final signupProvider = context.read<SignupProvider>();
      final prefs = await SharedPreferences.getInstance();
      final currentActivity = prefs.getString('current_activity');

      if (currentActivity != null) {
        // Coming from edit profile
        isFromEditProfile = true;
        final activityKey = _reverseActivityMap[currentActivity] ?? 'level1';
        _selectedActivityLevel.value = activityKey;
        setState(() {
          isLoading = false;
        });
        return;
      }

      if (isFromEditProfile) {
        // Try to get data from profile cubit
        try {
          final profileCubit = getIt<ProfileCubit>();
          final state = profileCubit.state;

          if (state is GetUserDataSuccessState && state.user != null) {
            _selectedActivityLevel.value = state.user?.activityLevel ?? 'level1';
            setState(() {
              isLoading = false;
            });
            return;
          }

          await profileCubit.getUserData();
          await Future.delayed(Duration(milliseconds: 300));

          final newState = profileCubit.state;
          if (newState is GetUserDataSuccessState && newState.user != null) {
            _selectedActivityLevel.value = newState.user?.activityLevel ?? 'level1';
            setState(() {
              isLoading = false;
            });
            return;
          }
        } catch (e) {
          print("Error accessing profile data: $e");
        }
      }

      _selectedActivityLevel.value = signupProvider.getData("activityLevel");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error loading activity data: $e");
      setState(() {
        isLoading = false;
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
    final signupProvider = context.read<SignupProvider>();

    return WillPopScope(
      onWillPop: () async {
        if (isFromEditProfile && _selectedActivityLevel.value != null) {
          final displayActivity = _activityMap[_selectedActivityLevel.value!] ?? 'Rookie';
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('edit_profile_activity', displayActivity);
        }
        return true;
      },
      child: Builder(
        builder: (context) {
          Widget content = isLoading
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
                        if (isFromEditProfile && _selectedActivityLevel.value != null) {
                          final displayActivity = _activityMap[_selectedActivityLevel.value!] ?? 'Rookie';
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('edit_profile_activity', displayActivity);
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
                  Center(child: ProgressIndicatorWidget(currentPage: 6, totalPages: 6)),
                25.verticalSpace,
                Text(
                  local.your_regular_physical_activity_level,
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
                          label: local.level1,
                          value: "level1",
                          groupValue: selectedValue,
                          onChanged: (value) {
                            _selectedActivityLevel.value = value;
                            if (!isFromEditProfile) {
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
                            _selectedActivityLevel.value = value;
                            if (!isFromEditProfile) {
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
                            _selectedActivityLevel.value = value;
                            if (!isFromEditProfile) {
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
                            _selectedActivityLevel.value = value;
                            if (!isFromEditProfile) {
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
                            _selectedActivityLevel.value = value;
                            if (!isFromEditProfile) {
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
                  valueListenable: _selectedActivityLevel,
                  builder: (context, selectedValue, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        color: AppColors.kOrange,
                        onPressed: selectedValue != null
                            ? () async {
                          if (isFromEditProfile) {
                            final displayActivity = _activityMap[selectedValue] ?? 'Rookie';
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('edit_profile_activity', displayActivity);
                            Navigator.pop(context);
                          } else {
                            try {
                              final signUpCubit = context.read<SignUpCubit>();
                              signupProvider.saveData("activityLevel", selectedValue);

                              final requestBody = SignupRequestBody(
                                firstName: signupProvider.getData("firstName"),
                                lastName: signupProvider.getData("lastName"),
                                email: signupProvider.getData("email"),
                                password: signupProvider.getData("password"),
                                rePassword: signupProvider.getData("rePassword"),
                                height: int.tryParse(signupProvider.getData("height") ?? '') ?? 0,
                                weight: int.tryParse(signupProvider.getData("weight") ?? '') ?? 0,
                                age: int.tryParse(signupProvider.getData("age") ?? '') ?? 0,
                                gender: signupProvider.getData("gender"),
                                goal: signupProvider.getData("goal"),
                                activityLevel: selectedValue,
                              );
                              signUpCubit.signUp(requestBody);
                            } catch (e) {
                              print("Error accessing SignUpCubit: $e");
                              Navigator.pushNamed(context, PageRouteName.mainSignUp);
                            }
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
          );
          if (!isFromEditProfile) {
            try {
              context.read<SignUpCubit>();

              return CustomScaffold(
                backgroundImage: AppImages.authBackground,
                enableBlur: true,
                blurStrength: 5.0,
                blurHeight: 385.0,
                blurWidth: 370.0.w,
                borderRadius: 50.0,
                blurStartPosition: MediaQuery.of(context).size.height * 0.38,
                child: BlocListener<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpLoading) {
                      AppDialogs.showLoading(context: context);
                    } else if (state is SignUpSuccess) {
                      AppDialogs.showHideDialog(context);
                      AppDialogs.showSuccessDialog(
                          context: context,
                          message: "Create account successfully!! please login in"
                      );
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(context, PageRouteName.login);
                      });
                    } else if (state is SignUpFail) {
                      AppDialogs.showHideDialog(context);
                      AppDialogs.showErrorDialog(
                          context: context,
                          errorMassage: state.errorMassage!
                      );
                    }
                  },
                  child: content,
                ),
              );
            } catch (e) {
              print("No SignUpCubit available, using basic scaffold: $e");
            }
          }

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
        },
      ),
    );
  }
}