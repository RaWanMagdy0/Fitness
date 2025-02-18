import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/page_route_name.dart' show PageRouteName;
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart' show AppDialogs;
import '../../../../core/utils/widget/custom scaffold.dart' show CustomScaffold;
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../cubit/forgot_password_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 230.0,
      blurWidth: 370.0.w,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.32,
      backgroundImage: AppImages.authBackground,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordComplete) {
              AppDialogs.showSuccessDialog(
                context: context,
                message: "Password reset successfully",
                whenAnimationFinished: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    PageRouteName.login,
                        (route) => false,
                  );
                },
              );
            } else if (state is ForgotPasswordError) {
              AppDialogs.showErrorDialog(
                context: context,
                errorMassage: state.message,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.verticalSpace,
                  Center(child: Image.asset(AppImages.logoIcon)),
                  40.verticalSpace,
                  Text(
                    "Create New Password",
                    style: AppFonts.font24WhiteWeight800,
                  ),
                  8.verticalSpace,
                  Text(
                    "Make Sure It's 8 Characters Or More",
                    style: AppFonts.font18WhiteWeight400,
                  ),
                  40.verticalSpace,
                  CustomTextFormField(
                    backgroundColor: Colors.white.withOpacity(0.1),

                    controller: _passwordController,
                    hintText: "Enter new password",
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                    validator: Validators.validatePassword,
                  ),
                  16.verticalSpace,
                  CustomTextFormField(
                    backgroundColor: Colors.white.withOpacity(0.1),

                    controller: _confirmPasswordController,
                    hintText: "Confirm new password",
                    isPassword: true,
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                    validator: (value) => Validators.validatePasswordConfirmation(
                      password: _passwordController.text,
                      confirmPassword: value,
                    ),
                  ),
                  32.verticalSpace,
                  if (state is ForgotPasswordLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ForgotPasswordCubit>().resetPassword(
                            _passwordController.text,
                          );
                        }
                      },
                      child: Text("Done", style: AppFonts.font16WhiteWeight500),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}