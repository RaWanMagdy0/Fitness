import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/images/app_images.dart';
import '../view_model/home_cubit.dart';

class UpcomingCard extends StatefulWidget {
  const UpcomingCard({
    super.key,
  });

  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}
class _UpcomingCardState extends State<UpcomingCard> {
  int selectedIndex = 0;
  late HomeCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    viewModel.getMuscleGroups();
  }


  @override
  Widget build(BuildContext context) {

            return SizedBox(
      height: 110.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return buildCardWidget(
              "running" ?? "", AppImages.chestExerciseImage);
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 15.w);
        },
      ),
    );
  }
}

buildCardWidget(String title, String imagePath) {
  return Container(
    width: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            imagePath,
            width: 90.w,
            height: 90.h,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.kMainColor.withOpacity(0.5),
                AppColors.kMainColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
