import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/routes/page_route_name.dart';
import '../../../../../../core/styles/colors/app_colors.dart';
import '../../../../../../core/utils/functions/validators/validators.dart';
import '../../../../../../core/utils/widget/custom_button.dart';
import '../../../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../domain/repository/auth_repository/auth_repository.dart';
import '../../view/widgets/custom_profile_row.dart';
import '../view_model/change_password_state.dart';
import '../view_model/change_password_view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return CustomScaffold(
      backgroundImage: AppImages.backgroundRobot,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 370.0,
      blurWidth: 350.0,
      borderRadius: 30.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.3,
      child: BlocConsumer<ChangePasswordViewModel, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Password updated successfully',
                  style: AppFonts.font14GreyWeight400,
                ),
                backgroundColor: AppColors.kOrange,
              ),
            );
          } else if (state is ChangePasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$state.errorMessage'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            AppImages.back,
                          )),
                      120.horizontalSpace,
                      Center(child: Image.asset(AppImages.logoIcon))
                    ],
                  ),
                  SizedBox(height: 150.h),
                  Center(
                      child: Text(
                    "Change Password",
                    style: AppFonts.font24WhiteWeight600,
                  )),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    controller: _currentPasswordController,
                    hintText: "CurrentPassword",
                    isPassword: true,
                    validator: (value) => Validators.validatePassword(value),
                    keyBordType: TextInputType.text,
                    labelText: '',
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    controller: _newPasswordController,
                    hintText: "NewPassword",
                    isPassword: true,
                    validator: (value) => Validators.validatePassword(value),
                    keyBordType: TextInputType.text,
                    labelText: '',
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password ",
                    isPassword: true,
                    keyBordType: TextInputType.text,
                    labelText: '',
                    validator: (value) {
                      if (value != _newPasswordController.text) {
                        return "Password Dont Match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),
                  CustomButton(
                    text: state is ChangePasswordLoading
                        ? "loading"
                        : "Update Text",
                    color: AppColors.kOrange,
                    onPressed: state is ChangePasswordLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context
                                  .read<ChangePasswordViewModel>()
                                  .changePassword(
                                    currentPassword:
                                        _currentPasswordController.text,
                                    newPassword: _newPasswordController.text,
                                    confirmPassword:
                                        _confirmPasswordController.text,
                                  );
                            }
                          },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
