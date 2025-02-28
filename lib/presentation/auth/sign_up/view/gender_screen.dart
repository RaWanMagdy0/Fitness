import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/generated/l10n.dart';
import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../generated/l10n.dart';
import '../widgets/custom_gender_container.dart';
import '../widgets/custom_indecator.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;
  double blurHeight = 350.0;
  @override
  void initState() {
    super.initState();
    final signupProvider = context.read<SignupProvider>();
    selectedGender = signupProvider.getData("gender") ?? "";
  }

  void _onGenderSelected(String gender) {
    setState(() {
      selectedGender = gender;
    });
    final signupProvider = context.read<SignupProvider>();
    signupProvider.saveData("gender", gender);
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final signupProvider = context.read<SignupProvider>();

    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: blurHeight,
      blurWidth: 370.0.w,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.36,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageRouteName.mainSignUp);
                  },
                  child: Image.asset(AppImages.back),
                ),
                100.horizontalSpace,
                Image.asset(AppImages.logoIcon),
              ],
            ),
            40.verticalSpace,
            Center(
                child: ProgressIndicatorWidget(currentPage: 1, totalPages: 6)),
            30.verticalSpace,
            Text(
              local.tell_us_about_yourself,
              style: AppFonts.font20WhiteWeight800,
            ),
            Text(
              local.we_need_to_know_your_gender,
              style: AppFonts.font18WhiteWeight400,
            ),
            30.verticalSpace,
            Column(
              children: [
                CustomGenderContainer(
                    image: AppImages.maleIcon,
                    text: local.male,
                    selected: selectedGender == "male",
                    onTap: () => _onGenderSelected("male")),
                40.verticalSpace,
                CustomGenderContainer(
                    image: AppImages.femaleIcon,
                    text: local.female,
                    selected: selectedGender == "female",
                    onTap: () => _onGenderSelected("female")),
                20.verticalSpace,
                if (selectedGender != null)
                  CustomButton(
                    onPressed: () {
                      signupProvider.saveData("gender", selectedGender!);
                      Navigator.pushReplacementNamed(
                          context, PageRouteName.ageScreen);
                    },
                    backgroundColor: AppColors.kOrange,
                    maxHeight: 10.h,
                    maxWidth: 10.w,
                    child:
                        Text(local.next, style: AppFonts.font14WhiteWeight800),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
