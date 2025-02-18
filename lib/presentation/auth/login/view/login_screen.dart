import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/generated/l10n.dart';
import '../../../../core/routes/page_route_name.dart' show PageRouteName;
import '../../../../core/styles/colors/app_colors.dart' show AppColors;
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart'
    show AppDialogs;
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../core/utils/widget/custom scaffold.dart' show CustomScaffold;
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../view_model/login_cubit.dart' show LoginCubit;
import '../view_model/login_state.dart'
    show LoginError, LoginLoading, LoginState, LoginSuccess;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          AppDialogs.showLoading(context: context);
        } else if (state is LoginSuccess) {
          AppDialogs.showHideDialog(context);
          AppDialogs.showSuccessDialog(
            context: context,
            message: state.message,
          );
        } else if (state is LoginError) {
          AppDialogs.showHideDialog(context);
          AppDialogs.showErrorDialog(
            context: context,
            errorMassage: state.error,
          );
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          backgroundImage: AppImages.authBackground,
          enableBlur: true,
          blurStrength: 5.0,
          blurHeight: 400.0,
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
                Text("WELCOME BACK", style: AppFonts.font20WhiteWeight800),
                20.verticalSpace,
                Text("Login", style: AppFonts.font24WhiteWeight800),
                20.verticalSpace,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailController,
                        hintText: local.emailHintText,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.kLighterGrey,
                        ),
                        backgroundColor: Colors.white.withOpacity(0.1),
                        validator: (value) => Validators.validateEmail(value),
                      ),
                      16.verticalSpace,
                      CustomTextFormField(
                        controller: _passwordController,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.kLighterGrey,
                        ),
                        backgroundColor: Colors.white.withOpacity(0.1),
                        hintText: local.passwordHintText,
                        isPassword: true,
                        validator:
                            (value) => Validators.validatePassword(value),
                      ),
                      26.verticalSpace,
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget Password ?',
                              style: TextStyle(color: AppColors.kOrange),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                          child: Text(
                            "Login",
                            style: AppFonts.font16WhiteWeight500,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            local.donotHaveAccountText,
                            style: AppFonts.font14WhiteWeight400,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                PageRouteName.mainSignUp,
                              );
                            },
                            child: Text(
                              local.signUpTitle,
                              style: AppFonts.font14LightOrangeWeight400,
                            ),
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
      },
    );
  }
}
