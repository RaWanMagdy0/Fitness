import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/page_route_name.dart' show PageRouteName;
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart'
    show AppDialogs;
import '../../../../core/utils/widget/custom scaffold.dart' show CustomScaffold;
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/custom_otp_field.dart';
import '../../../../core/styles/images/app_images.dart';
import '../cubit/forgot_password_cubit.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  String _code = '';

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeComplete() {
    if (_code.length == 6) {
      context.read<ForgotPasswordCubit>().verifyCode(_code);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            if (state is ForgotPasswordCodeVerified) {
              Navigator.pushNamed(context, PageRouteName.resetPassword);
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.verticalSpace,
                Center(child: Image.asset(AppImages.logoIcon)),
                40.verticalSpace,
                Text(
                  "OTP CODE",
                  style: AppFonts.font24WhiteWeight800,
                ),
                8.verticalSpace,
                Text(
                  "Enter Your OTP Check Your Email",
                  style: AppFonts.font18WhiteWeight400,
                ),
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => CustomOTPField(

                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      autoFocus: index == 0,
                      onChanged: (value) {
                        setState(() {
                          _code = _code.padRight(index) + value;
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          }
                        });
                        if (index == 5) {
                          _onCodeComplete();
                        }
                      },
                    ),
                  ),
                ),
                32.verticalSpace,
                if (state is ResendTimerStarted) ...[
                  Center(
                    child: Text(
                      "Resend code in ${state.secondsRemaining}s",
                      style: AppFonts.font14WhiteWeight400,
                    ),
                  ),
                ] else if (state is ResendTimerComplete) ...[
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<ForgotPasswordCubit>()
                            .sendForgotPasswordEmail(
                              context.read<ForgotPasswordCubit>().userEmail?? "",
                            );
                      },
                      child: Text(
                        "Resend Code?",
                        style: AppFonts.font14LightOrangeWeight400,
                      ),
                    ),
                  ),
                ],
                CustomButton(
                  onPressed: _onCodeComplete,
                  child: Text("Confirm", style: AppFonts.font16WhiteWeight500),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
