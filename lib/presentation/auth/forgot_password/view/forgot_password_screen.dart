import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/page_route_name.dart' show PageRouteName;
import '../../../../core/styles/fonts/app_fonts.dart' show AppFonts;
import '../../../../core/styles/images/app_images.dart' show AppImages;
import '../../../../core/utils/functions/dialogs/app_dialogs.dart'
    show AppDialogs;
import '../../../../core/utils/widget/custom scaffold.dart' show CustomScaffold;
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_text_form_field.dart';
import '../../../../core/utils/functions/validators/validators.dart';
import '../../../../generated/l10n.dart';
import '../cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var viewModel = getIt.get<ForgotPasswordCubit>();
  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgotPasswordCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return CustomScaffold(
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 200.0,
      blurWidth: 370.0.w,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.32,
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
            } else if (state is ForgotPasswordLoading) {
              AppDialogs.showLoading(
                context: context,
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
                    local.forget_password,
                    style: AppFonts.font24WhiteWeight800,
                  ),
                  10.verticalSpace,
                  Text(
                    local.enter_your_email,
                    style: AppFonts.font18WhiteWeight400,
                  ),
                  50.verticalSpace,
                  CustomTextFormField(
                    controller: viewModel.emailController,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    hintText: local.enter_your_email,
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    validator: Validators.validateEmail,
                  ),
                  32.verticalSpace,
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<ForgotPasswordCubit>()
                            .sendForgotPasswordEmail(
                              viewModel.emailController.text,
                            );
                      }
                    },
                    child:
                        Text(local.sent_otp, style: AppFonts.font16WhiteWeight500),
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
