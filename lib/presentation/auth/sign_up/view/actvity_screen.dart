import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/const/app_string.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:fitness_app/core/utils/widget/custom_radio.dart';
import 'package:fitness_app/presentation/auth/sign_up/view_model/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../data/models/sign_up/request/sign_up_request_body.dart';
import '../widgets/custom_indecator.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ValueNotifier<String?> _selectedActivityLevel =
      ValueNotifier<String?>(null);
  @override
  void initState() {
    super.initState();
    final signupProvider = context.read<SignupProvider>();
    _selectedActivityLevel.value = signupProvider.getData("activityLevel");
  }

  @override
  void dispose() {
    _selectedActivityLevel.dispose();
    super.dispose();
  }

  void _onNextPressed(BuildContext context) {
    final signupProvider = context.read<SignupProvider>();
    final signUpCubit = context.read<SignUpCubit>();
    if (_selectedActivityLevel.value != null) {
      signupProvider.saveData(
          "activityLevel", _selectedActivityLevel.toString());
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
        activityLevel: _selectedActivityLevel.value,
      );
      signUpCubit.signUp(requestBody);
      //  Navigator.pushNamed(context, PageRouteName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = context.read<SignupProvider>();
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          AppDialogs.showLoading(context: context);

        } else if (state is SignUpSuccess) {
          AppDialogs.showSuccessDialog(context: context, message: "Create account successfully!! please login in");
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, PageRouteName.login);
          });
        } else if (state is SignUpFail) {
          AppDialogs.showErrorDialog(context: context, errorMassage: state.errorMassage!);

        }
      },
      child: CustomScaffold(
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
                      Navigator.pushNamed(context, PageRouteName.goalScreen);
                    },
                    child: Image.asset(AppImages.back),
                  ),
                  100.horizontalSpace,
                  Image.asset(AppImages.logoIcon),
                ],
              ),
              50.verticalSpace,
              Center(
                  child:
                      ProgressIndicatorWidget(currentPage: 6, totalPages: 6)),
              25.verticalSpace,
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
                        label: "level1",
                        value: "level1",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedActivityLevel.value = value;
                          signupProvider.saveData("activityLevel", value);
                        },
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: "level2",
                        value: "level2",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedActivityLevel.value = value;
                          signupProvider.saveData("activityLevel", value);
                        },
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: "level3",
                        value: "level3",
                        groupValue: selectedValue,
                        onChanged: (value) =>
                            _selectedActivityLevel.value = value,
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: "level4",
                        value: "level4",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedActivityLevel.value = value;
                          signupProvider.saveData("activityLevel", value);
                        },
                      ),
                      16.verticalSpace,
                      CustomRadioButton(
                        label: "level5",
                        value: "level5",
                        groupValue: selectedValue,
                        onChanged: (value) {
                          _selectedActivityLevel.value = value;
                          signupProvider.saveData("activityLevel", value);
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
                          ? () => _onNextPressed(context)
                          : null,
                      child: Text(
                        AppStrings.next,
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
