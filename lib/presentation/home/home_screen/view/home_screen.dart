import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';
import '../widget/category_section.dart';
import '../widget/popular_card.dart';
import '../widget/recomm_card.dart';
import '../widget/recomm_food_card.dart';
import '../widget/upcoming_card.dart';
import '../widget/upcoming_tabs.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final cubit = context.watch<ProfileCubit>();
                      if (state is ProfileInitialState) {
                        cubit.getUserData();
                      }
                      final userName = cubit.userName;
                      final userImage = cubit.userImage;

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Hi ",
                                        style: AppFonts.font16WhiteWeight500),
                                    const SizedBox(width: 2),
                                    Text(userName ?? "Rowan",
                                        style: AppFonts.font16WhiteWeight500),
                                    Text(",",
                                        style: AppFonts.font16WhiteWeight500),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text("Let's Start Your Day",
                                    style: AppFonts.font18WhiteWeight400),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: userImage == null
                                  ? _buildShimmerEffect()
                                  : ClipOval(
                                child: Image.network(
                                  userImage,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return _buildShimmerEffect();
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(AppImages.chestExerciseImage);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                   10.verticalSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Category", style: AppFonts.font18WhiteWeight400),
                            const SizedBox(height: 10),
                            const CategorySection(),
                            const SizedBox(height: 20),
                            Text("Recommendation Today", style: AppFonts.font18WhiteWeight400),
                            const RecommCard(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Upcoming Workouts", style: AppFonts.font18WhiteWeight400),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, PageRouteName.workoutScreen);
                                  },
                                  child: Text(
                                    "See All",
                                    style: AppFonts.font15OrangeWeight500.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.kOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const CategoryTabs(),
                            const UpcomingCard(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Recommendation For You", style: AppFonts.font18WhiteWeight400),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "See All",
                                    style: AppFonts.font15OrangeWeight500.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.kOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const RecommFoodCard(),
                            const SizedBox(height: 30),
                            Text("Popular Training", style: AppFonts.font18WhiteWeight400),
                            const PopularCard(),
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
  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
