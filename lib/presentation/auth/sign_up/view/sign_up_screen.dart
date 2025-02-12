import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/generated/l10n.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 460.0,
      blurWidth: 350.0,
      borderRadius: 30.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.3,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.verticalSpace,
            Center(child: Image.asset(AppImages.logoIcon)),
            40.verticalSpace,
            Text("Hey There", style: AppFonts.font18WhiteWeight400),
            8.verticalSpace,
            Text("CREATE AN ACCOUNT", style: AppFonts.font20WhiteWeight800),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register", style: AppFonts.font24WhiteWeight800),
              ],
            ),
            20.verticalSpace,
            Form(
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: local.firstNameHintText,
                    prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    validator: (value) => Validators.validateName(value),
                  ),
                  16.verticalSpace,
                  CustomTextFormField(
                    hintText: local.lastNameHintText,
                    prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    validator: (value) => Validators.validateName(value),
                  ),
                  16.verticalSpace,
                  CustomTextFormField(
                    hintText: local.emailHintText,
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    validator: (value) => Validators.validateEmail(value),
                  ),
                  16.verticalSpace,
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    hintText: local.signupPasswordHintText,
                    isPassword: true,
                    validator: (value) => Validators.validatePassword(value),
                    keyBordType: TextInputType.text,
                  ),
                  32.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: () {},
                      child: Text("Register", style: AppFonts.font16WhiteWeight500),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(local.alreadyHaveAccount, style: AppFonts.font14WhiteWeight400),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text(local.loginTitle, style: AppFonts.font14LightOrangeWeight400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
