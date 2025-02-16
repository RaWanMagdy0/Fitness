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
import '../widgets/custom_gender_container.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;
  double blurHeight = 300.0;
  @override
  void initState() {
    super.initState();
    final signupProvider = context.read<SignupProvider>();
    selectedGender = signupProvider.getData("gender") ?? "";
  }

  void _onGenderSelected(String gender) {
    setState(() {
      selectedGender = gender;
      blurHeight = 400.0;
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
      blurWidth: 350.0,
      borderRadius: 30.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.3,
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
                    Navigator.pushNamed(context, PageRouteName.mainSignUp);
                  },
                  child: Image.asset(AppImages.back),
                ),
                100.horizontalSpace,
                Image.asset(AppImages.logoIcon),
              ],
            ),
            40.verticalSpace,
            Text(
              "TELL US ABOUT YOURSELF!",
              style: AppFonts.font20WhiteWeight800,
            ),
            8.verticalSpace,
            Text(
              "We Need To Know Your Gender",
              style: AppFonts.font18WhiteWeight400,
            ),
            50.verticalSpace,
            Column(
              children: [
                CustomGenderContainer(
                    image: AppImages.maleIcon,
                    text: "Male",
                    selected: selectedGender == "Male",
                    onTap: () => _onGenderSelected("Male")),
                40.verticalSpace,
                CustomGenderContainer(
                    image: AppImages.femaleIcon,
                    text: "Female",
                    selected: selectedGender == "Female",
                    onTap: () => _onGenderSelected("Female")),
                20.verticalSpace,
                if (selectedGender != null)
                  CustomButton(
                    onPressed: () {
                      signupProvider.saveData("firstName", selectedGender!);
                      Navigator.pushReplacementNamed(
                          context, PageRouteName.goalScreen);
                    },
                    backgroundColor: AppColors.kOrange,
                    maxHeight: 10.h,
                    maxWidth: 10.w,
                    child: Text("Next", style: AppFonts.font14WhiteWeight800),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
