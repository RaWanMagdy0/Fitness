import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/page_route_name.dart' show PageRouteName;
import '../../../../core/styles/fonts/app_fonts.dart' show AppFonts;
import '../../../../core/styles/images/app_images.dart' show AppImages;
import '../../../../core/utils/functions/dialogs/app_dialogs.dart' show AppDialogs;
import '../../../../core/utils/widget/custom scaffold.dart' show CustomScaffold;
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordEmailSent) {
              Navigator.pushNamed(context, PageRouteName.verifyCode);
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
                    "Forget Password",
                    style: AppFonts.font24WhiteWeight800,
                  ),
                  20.verticalSpace,
                  Text(
                    "Enter Your Email",
                    style: AppFonts.font18WhiteWeight400,
                  ),
                  20.verticalSpace,
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: "Enter your email",
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    validator: Validators.validateEmail,
                  ),
                  32.verticalSpace,
                  if (state is ForgotPasswordLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ForgotPasswordCubit>().sendForgotPasswordEmail(
                            _emailController.text,
                          );
                        }
                      },
                      child: Text("Send OTP", style: AppFonts.font16WhiteWeight500),
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