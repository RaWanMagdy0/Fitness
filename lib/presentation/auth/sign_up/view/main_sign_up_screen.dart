import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/generated/l10n.dart';
import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../view_model/sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpCubit signUpCubit;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    signUpCubit = context.read<SignUpCubit>();
    final signupProvider = context.read<SignupProvider>();

    signUpCubit.firstNameController.text = signupProvider.getData("firstName") ?? "";
    signUpCubit.lastNameController.text = signupProvider.getData("lastName") ?? "";
    signUpCubit.emailController.text = signupProvider.getData("email") ?? "";
    signUpCubit.passwordController.text = signupProvider.getData("password") ?? "";
    Future.microtask(() {
      validateForm();
    });
  }



  void validateForm() {
    setState(() {
      isButtonEnabled = signUpCubit.firstNameController.text.isNotEmpty &&
          signUpCubit.lastNameController.text.isNotEmpty &&
          signUpCubit.emailController.text.isNotEmpty &&
          signUpCubit.passwordController.text.isNotEmpty &&
          (signUpCubit.formKey.currentState?.validate() ?? false);
    });
  }


  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    final signUpCubit = context.read<SignUpCubit>();
    final signupProvider = context.read<SignupProvider>();
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 430.0,
      blurWidth: 350.0,
      borderRadius: 30.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.31,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.verticalSpace,
              Center(child: Image.asset(AppImages.logoIcon)),
              40.verticalSpace,
              Text("Hey There", style: AppFonts.font18WhiteWeight400),
              8.verticalSpace,
              Text("CREATE AN ACCOUNT", style: AppFonts.font20WhiteWeight800),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Register", style: AppFonts.font24WhiteWeight800),
                ],
              ),
              20.verticalSpace,
              Form(
                key: signUpCubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                          controller: signUpCubit.firstNameController,
                          hintText: local.firstNameHintText,
                          prefixIcon:
                              Icon(Icons.person_outline, color: Colors.grey),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          validator: (value) => Validators.validateName(value),
                          onChanged: (value) {
                            signupProvider.saveData("firstName", value);
                            validateForm();
                          }),
                      16.verticalSpace,
                      CustomTextFormField(
                          controller: signUpCubit.lastNameController,
                          hintText: local.lastNameHintText,
                          prefixIcon:
                              Icon(Icons.person_outline, color: Colors.grey),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          validator: (value) => Validators.validateName(value),
                          onChanged: (value) {
                            signupProvider.saveData("lastName", value);
                            validateForm();
                          }),
                      16.verticalSpace,
                      CustomTextFormField(
                          controller: signUpCubit.emailController,
                          hintText: local.emailHintText,
                          prefixIcon:
                              Icon(Icons.email_outlined, color: Colors.grey),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          validator: (value) => Validators.validateEmail(value),
                          onChanged: (value) {
                            signupProvider.saveData("email", value);
                            validateForm();
                          }),
                      16.verticalSpace,
                      CustomTextFormField(
                          controller: signUpCubit.passwordController,
                          prefixIcon:
                              Icon(Icons.lock_outline, color: Colors.grey),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          hintText: local.signupPasswordHintText,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePassword(value),
                          keyBordType: TextInputType.text,
                          onChanged: (value) {
                            signupProvider.saveData("password", value);
                            validateForm();
                          }),
                      32.verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: isButtonEnabled
                              ? () {
                            signupProvider.saveData("firstName",
                                signUpCubit.firstNameController.text);
                            signupProvider.saveData("lastName",
                                signUpCubit.lastNameController.text);
                            signupProvider.saveData(
                                "email", signUpCubit.emailController.text);
                            signupProvider.saveData("password",
                                signUpCubit.passwordController.text);
                            Navigator.pushNamed(
                                context, PageRouteName.genderSignUp);
                          }
                              : null,
                          color: isButtonEnabled
                              ? AppColors.kOrange
                              : Colors.grey,
                          child: Text("Next",
                              style: AppFonts.font16WhiteWeight500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(local.alreadyHaveAccount,
                              style: AppFonts.font14WhiteWeight400),
                          TextButton(
                            onPressed: () {},
                            child: Text(local.loginTitle,
                                style: AppFonts.font14LightOrangeWeight400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
