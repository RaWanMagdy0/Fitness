import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/presentation/home/home_screen/widget/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';
import '../widget/category_section.dart';
import '../widget/popular_card.dart';
import '../widget/recomm_card.dart';
import '../widget/recomm_food_card.dart';
import '../widget/upcoming_card.dart';
import '../widget/upcoming_tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMuscleGroupId = "";
  late HomeCubit viewModel;
  late ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    profileCubit = getIt.get<ProfileCubit>();
  }

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
                  HomeAppBar(profileCubit: profileCubit),
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
                            Text("Category",
                                style: AppFonts.font18WhiteWeight400),
                            const SizedBox(height: 10),
                            const CategorySection(),
                            const SizedBox(height: 20),
                            Text("Recommendation Today",
                                style: AppFonts.font18WhiteWeight400),
                            const RecommCard(),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Upcoming Workouts",
                                    style: AppFonts.font18WhiteWeight400),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRouteName.workoutScreen);
                                  },
                                  child: Text(
                                    "See All",
                                    style:
                                    AppFonts.font15OrangeWeight500.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.kOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            CategoryTabs(
                              onTabSelected: (muscleGroupId) {
                                if (selectedMuscleGroupId != muscleGroupId) {
                                  setState(() {
                                    selectedMuscleGroupId = muscleGroupId;
                                  });
                                  viewModel.getMuscleGroupById(muscleGroupId);
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            if (selectedMuscleGroupId.isNotEmpty)
                              BlocBuilder<HomeCubit, HomeState>(
                                bloc: viewModel,
                                builder: (context, state) {
                                  if (state is MuscleGroupIdLoading) {
                                    return _buildShimmerTabs();
                                  } else if (state is MuscleGroupIdError) {
                                    return Center(
                                        child: Text(
                                            "Error: ${state.errorMessage}"));
                                  } else if (state is MuscleGroupIdSuccess) {
                                    return UpcomingCard(
                                        muscleGroupId: selectedMuscleGroupId);
                                  }
                                  return Container();
                                },
                              ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Recommendation For You",
                                    style: AppFonts.font18WhiteWeight400),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PageRouteName.mealsScreen);
                                  },
                                  child: Text(
                                    "See All",
                                    style:
                                    AppFonts.font15OrangeWeight500.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.kOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const RecommFoodCard(),
                            const SizedBox(height: 30),
                            Text("Popular Training",
                                style: AppFonts.font18WhiteWeight400),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PageRouteName.exerciseScreen);
                                },
                                child: const PopularCard()),
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

  Widget _buildShimmerTabs() {
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: ShimmerLoadingWidget(
              width: 90.w,
              height: 90.h,
              borderRadius: 20.r,
            ),
          );
        },
      ),
    );
  }
}
