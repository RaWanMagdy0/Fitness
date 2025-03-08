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
import '../widget/upcoming_tabs.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScaffold(
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
                            SizedBox(height: 5),
                            Text("Let's Start Your Day", style: AppFonts.font18WhiteWeight400),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(AppImages.person),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 100),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Category", style: AppFonts.font18WhiteWeight400),
                            SizedBox(height: 10),
                            CategorySection(),
                            SizedBox(height: 20),
                            Text("Recommendation Today", style: AppFonts.font18WhiteWeight400),
                            RecommCard(),
                            SizedBox(height: 20),
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
                            15.verticalSpace,
                            CategoryTabs(),
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
          ),
        ],
      ),
    );
  }
}
