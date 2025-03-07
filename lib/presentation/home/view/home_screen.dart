import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import '../../../core/styles/images/app_images.dart';
import '../widget/category_section.dart';
import '../widget/popular_card.dart';
import '../widget/recomm_card.dart';
import '../widget/upcoming_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScaffold(
            backgroundImage: AppImages.homeBackG,
            overlayOpacity: 0.1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Hi", style: AppFonts.font16WhiteWeight500),
                              Text(" Ahmed,", style: AppFonts.font16WhiteWeight500),
                            ],
                          ),
                          5.verticalSpace,
                          Text("Let's Start Your Day", style: AppFonts.font18WhiteWeight400),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                        width: 60.w,
                        child: Image.asset(AppImages.person),
                      ),
                    ],
                  ),
                ),

                10.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100.h),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category", style: AppFonts.font18WhiteWeight400),
                          10.verticalSpace,
                          CategorySection(),
                          20.verticalSpace,
                          Text("Recommendation Today", style: AppFonts.font18WhiteWeight400),
                          RecommCard(),
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Upcoming Workouts", style: AppFonts.font18WhiteWeight400),
                              Text(
                                "See All",
                                style: AppFonts.font15OrangeWeight500.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.kOrange,
                                ),
                              ),
                            ],
                          ),
                          UpcomingCard(),
                          30.verticalSpace,
                          Text("Popular Training", style: AppFonts.font18WhiteWeight400),
                          PopularCard(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
