import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'core/styles/images/app_images.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundImage: AppImages.authBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.verticalSpace,
              Lottie.asset(AppImages.errorAnim,),
              Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 20.sp, color: AppColors.kOrange),
              ),
              SizedBox(height: 10),
              Text(
                "Please check your network and try again",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
