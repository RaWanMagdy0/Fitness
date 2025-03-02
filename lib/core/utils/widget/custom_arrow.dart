import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/colors/app_colors.dart';
import '../../styles/images/app_images.dart';

class CustomArrow extends StatelessWidget {
  const CustomArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      width: 25.w,
      decoration: BoxDecoration(
          color: AppColors.kOrange, borderRadius: BorderRadius.circular(25.r)),
      child: Image.asset(AppImages.backArrow),
    );
  }
}
