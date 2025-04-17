import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/presentation/home/home_screen/widget/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/di/di.dart';
import '../../../../core/local/secure_storage.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
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
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    _initialize();
  }

  Future<void> _initialize() async {
     _checkAndShowLoginDialog();
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  void _checkAndShowLoginDialog() async {
    try {
      final hasShownDialog = await SecureStorageFactory.readData(
          key: 'has_shown_stay_logged_in_dialog') ==
          'true';
      final isNewLogin =
          await SecureStorageFactory.readData(key: 'is_new_login') == 'true';

      if (isNewLogin && !hasShownDialog && mounted) {
        await SecureStorageFactory.writeData(key: 'is_new_login', value: 'false');
        await SecureStorageFactory.writeData(
            key: 'has_shown_stay_logged_in_dialog', value: 'true');
        _showStayLoggedInDialog();
      }
    } catch (e) {
      debugPrint('Error checking login dialog: $e');
    }
  }  void _showStayLoggedInDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 280.w,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.kMainColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Stay Logged In",
                  style: AppFonts.font18WhiteWeight400,
                  textAlign: TextAlign.center,
                ),
                16.verticalSpace,
                Text(
                  "Would you like to stay logged in? You won’t need to log in every time you open the app.",
                  style: AppFonts.font14WhiteWeight400,
                  textAlign: TextAlign.center,
                ),
                24.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          _saveStayLoggedInPreference(true);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Yes",
                          style: AppFonts.font16WhiteWeight500,
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          _saveStayLoggedInPreference(false);
                          Navigator.of(context).pop();
                        },
                        color: Colors.grey,
                        child: Text(
                          "No",
                          style: AppFonts.font16WhiteWeight500,
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

  Future<void> _saveStayLoggedInPreference(bool stayLoggedIn) async {
    await SecureStorageFactory.writeData(
      key: 'stay_logged_in',
      value: stayLoggedIn.toString(),
    );
    debugPrint('Stay logged in preference saved: $stayLoggedIn');
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Container(
          color: AppColors.kMainColor,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.kOrange),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.homeBackG,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.1)),
          ),
          SafeArea(
            child: Column(
              children: [
                HomeAppBar(),
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
                                          "Error: \${state.errorMessage}"));
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
                          const PopularCard(),
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
