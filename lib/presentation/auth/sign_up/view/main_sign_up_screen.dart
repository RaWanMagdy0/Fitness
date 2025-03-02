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
import '../../../../generated/l10n.dart';
import '../view_model/sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpCubit signUpCubit;

  @override
  void initState() {
    super.initState();
    signUpCubit = context.read<SignUpCubit>();
    final signupProvider = context.read<SignupProvider>();
    signUpCubit.firstNameController.text =
        signupProvider.getData("firstName") ?? "";
    signUpCubit.lastNameController.text =
        signupProvider.getData("lastName") ?? "";
    signUpCubit.emailController.text = signupProvider.getData("email") ?? "";
    signUpCubit.passwordController.text =
        signupProvider.getData("password") ?? "";
    signUpCubit.rePasswordController.text =
        signupProvider.getData("rePassword") ?? "";
  }

  void validateForm() {
    setState(() {
       signUpCubit.firstNameController.text.isNotEmpty &&
          signUpCubit.lastNameController.text.isNotEmpty &&
          signUpCubit.emailController.text.isNotEmpty &&
          signUpCubit.passwordController.text.isNotEmpty &&
          signUpCubit.rePasswordController.text.isNotEmpty &&
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
      blurHeight: 480.0,
      blurWidth: 370.0.w,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.32,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.verticalSpace,
              Center(child: Image.asset(AppImages.logoIcon)),
              40.verticalSpace,
              Text(local.hey_there, style: AppFonts.font18WhiteWeight400),
              8.verticalSpace,
              Text(local.create_an_account, style: AppFonts.font20WhiteWeight800),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(local.register, style: AppFonts.font24WhiteWeight800),
                ],
              ),
              10.verticalSpace,
              Form(
                key: signUpCubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                          controller: signUpCubit.firstNameController,
                          hintText: local.first_name,
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
                          hintText: local.last_name,
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
                          hintText: local.email_text,
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
                          hintText: local.password,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePassword(value),
                          keyBordType: TextInputType.text,
                          onChanged: (value) {
                            signupProvider.saveData("password", value);
                            validateForm();
                          }),
                      16.verticalSpace,
                      CustomTextFormField(
                          controller: signUpCubit.rePasswordController,
                          prefixIcon:
                              Icon(Icons.lock_outline, color: Colors.grey),
                          backgroundColor: Colors.white.withOpacity(0.1),
                          hintText: local.confirm_password,
                          isPassword: true,
                          validator: (value) =>
                              Validators.validatePasswordConfirmation(
                                password: signUpCubit.passwordController.text,
                                confirmPassword: value,
                              ),
                          keyBordType: TextInputType.text,
                          onChanged: (value) {
                            signupProvider.saveData("rePassword", value);
                            validateForm();
                          }),
                      14.verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: () {
                            if (signUpCubit.formKey.currentState?.validate() ?? false) {
                              signupProvider.saveData("firstName", signUpCubit.firstNameController.text);
                              signupProvider.saveData("lastName", signUpCubit.lastNameController.text);
                              signupProvider.saveData("email", signUpCubit.emailController.text);
                              signupProvider.saveData("password", signUpCubit.passwordController.text);
                              signupProvider.saveData("rePassword", signUpCubit.rePasswordController.text);
                              Navigator.pushNamed(context, PageRouteName.genderSignUp);
                            }
                          },
                          color: AppColors.kOrange,
                          child: Text(local.next,
                              style: AppFonts.font16WhiteWeight500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(local.already_have_an_account,
                              style: AppFonts.font14WhiteWeight400),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, PageRouteName.login);
                            },
                            child: Text(local.login,
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
