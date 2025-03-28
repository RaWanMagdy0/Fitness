import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/presentation/home/home_screen/widget/static_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kBlackBG.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildWidget(context, AppImages.gymIcon, "Gym"),
            buildDivider(),
            buildWidget(context, AppImages.fitnessIcon, "Fitness"),
            buildDivider(),
            buildWidget(context, AppImages.yogaIcon, "Yoga"),
            buildDivider(),
            buildWidget(context, AppImages.aerobicsIcon, "Aerobics"),
            buildDivider(),
            buildWidget(context, AppImages.trainerIcon, "Trainer"),
          ],
        ),
      ),
    );
  }
}

Widget buildWidget(BuildContext context, String imagePath, String title) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StaticPage(iconPath: imagePath),
        ),
      );
    },
    child: Column(
      children: [
        Image.asset(imagePath, width: 50, height: 50),
        5.verticalSpace,
        Text(
          title,
          style: AppFonts.font12OrangeWeight400.copyWith(color: AppColors.kWhite),
        ),
      ],
    ),
  );
}

Widget buildDivider() {
  return SizedBox(
    height: 65.h,
    child: VerticalDivider(
      color: AppColors.kLightGrey,
      thickness: 1,
      width: 7.w,
    ),
  );
}
