import 'package:fitness_app/presentation/profile/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../routes/page_route_name.dart';
import '../../../styles/colors/app_colors.dart';
import '../../../styles/fonts/app_fonts.dart';
import '../../../styles/images/app_images.dart';
import '../../widget/custom_button.dart';

class AppDialogs {
  static Future<void> showLoading({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Lottie.asset(
            AppImages.fitLoad,
            height: 50.h,
            width: 20.w,
          ),
        );
      },
    );
  }

  static void showErrorDialog({
    required BuildContext context,
    required String errorMassage,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kWhite,
        icon: Lottie.asset(AppImages.errorAnimation, height: 80.h),
        content: Text(
          textAlign: TextAlign.center,
          errorMassage,
          style: AppFonts.font18BlackWeight500,
        ),
      ),
    );
  }

  static void showSuccessDialog({
    required BuildContext context,
    required String message,
    VoidCallback? whenAnimationFinished,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kWhite,
        icon: Lottie.asset(
          AppImages.successAnimation,
          height: 80.h,
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(
              composition.duration,
              () {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  if (whenAnimationFinished != null) {
                    whenAnimationFinished();
                  }
                }
              },
            );
          },
        ),
        content: Text(
          message,
          style: AppFonts.font18BlackWeight500,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void showHideDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void logoutDialog({
    required BuildContext context,
    required ProfileCubit profileCubit,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 300.w,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.kMainColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                5.verticalSpace,

                Text(
                  'LOGOUT',
                  style: AppFonts.font18WhiteWeight400
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                10.verticalSpace,
                Text(
                  'Confirm Logout !',
                  style: AppFonts.font15WhiteWeight500
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.grey,
                        child: Text(
                          "Cancel",
                          style: AppFonts.font16WhiteWeight500,
                        ),
                      ),
                    ),
                    10.horizontalSpace,

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(105.w, 40.h),
                          backgroundColor: AppColors.kOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            side: BorderSide(
                                color: Colors.transparent, width: 1.w),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          showLoading(context: context);
                          profileCubit.logout().then((_) {
                            showHideDialog(context);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              PageRouteName.login,
                                  (route) => false,
                            );
                          });
                        },
                        child: Text(
                          'Logout',
                          style: AppFonts.font15WhiteWeight500
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
