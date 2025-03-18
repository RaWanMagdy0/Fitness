import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/di.dart';
import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';
import '../widgets/custom_indecator.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  int selectedWeight = 90;
  final int minWeight = 30;
  final int maxWeight = 200;
  final ScrollController _scrollController = ScrollController();
  bool isFromEditProfile = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSourceAndLoadData();
    });
  }

  Future<void> _checkSourceAndLoadData() async {
    try {
      final signupProvider = context.read<SignupProvider>();
      final prefs = await SharedPreferences.getInstance();
      final currentWeight = prefs.getString('current_weight');

      if (currentWeight != null) {
        isFromEditProfile = true;
        setState(() {
          selectedWeight = int.tryParse(currentWeight) ?? 90;
          isLoading = false;
        });

        _scrollToSelectedWeight();
        return;
      }

      final route = ModalRoute.of(context);
      if (route != null && route.settings.name != PageRouteName.weightScreen) {
        // Most likely coming from EditProfileScreen
        final profileCubit = getIt<ProfileCubit>();
        final state = profileCubit.state;

        if (state is GetUserDataSuccessState && state.user != null) {
          isFromEditProfile = true;
          setState(() {
            selectedWeight = state.user?.weight ?? 90;
            isLoading = false;
          });

          _scrollToSelectedWeight();
          return;
        }

        await profileCubit.getUserData();
        await Future.delayed(Duration(milliseconds: 300)); // Small delay to allow state to update

        final newState = profileCubit.state;
        if (newState is GetUserDataSuccessState && newState.user != null) {
          isFromEditProfile = true;
          setState(() {
            selectedWeight = newState.user?.weight ?? 90;
            isLoading = false;
          });

          _scrollToSelectedWeight();
          return;
        }
      }

      setState(() {
        selectedWeight = int.tryParse(signupProvider.getData("weight") ?? '') ?? 50;
        isLoading = false;
      });

      _scrollToSelectedWeight();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _scrollToSelectedWeight() {
    if (_scrollController.hasClients) {
      final itemWidth = 30.0.w;
      final screenWidth = MediaQuery.of(context).size.width;
      final centerPosition = (selectedWeight - minWeight) * itemWidth - (screenWidth / 2) + itemWidth;

      _scrollController.animateTo(
        centerPosition > 0 ? centerPosition : 0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Future.delayed(Duration(milliseconds: 100), _scrollToSelectedWeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = context.read<SignupProvider>();

    return WillPopScope(
      onWillPop: () async {
        if (isFromEditProfile) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('edit_profile_weight', '$selectedWeight KG');
        }
        return true;
      },
      child: CustomScaffold(
        backgroundImage: AppImages.authBackground,
        enableBlur: true,
        blurStrength: 5.0,
        blurHeight: 230.h,
        blurWidth: 430.w,
        borderRadius: 50.r,
        blurStartPosition: MediaQuery.of(context).size.height * 0.36,
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.kOrange))
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (isFromEditProfile) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('edit_profile_weight', '$selectedWeight KG');
                        Navigator.pop(context);
                      } else {
                        Navigator.pushNamed(context, PageRouteName.ageScreen);
                      }
                    },
                    child: Image.asset(
                      AppImages.back,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                  100.horizontalSpace,
                  Image.asset(
                    AppImages.logoIcon,
                    width: 32.w,
                    height: 32.h,
                  ),
                ],
              ),
              40.verticalSpace,
              if (!isFromEditProfile)
                Center(
                  child: ProgressIndicatorWidget(currentPage: 3, totalPages: 6),
                ),
              30.verticalSpace,
              Text(
                "WHAT IS YOUR WEIGHT ?",
                style: AppFonts.font14WhiteWeight800.copyWith(fontSize: 20.sp),
              ),
              Text(
                "This Helps Us Create Your Personalized Plan",
                style: AppFonts.font18WhiteWeight400.copyWith(fontSize: 15.sp),
              ),
              20.verticalSpace,
              SizedBox(height: 80.h),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Text(
                    "Kg",
                    style: AppFonts.font12OrangeWeight400,
                  ),
                ),
              ),
              5.verticalSpace,
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 58.h,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: maxWeight - minWeight + 1,
                      itemBuilder: (context, index) {
                        int weight = minWeight + index;
                        bool isSelected = weight == selectedWeight;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedWeight = weight;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.w),
                            child: Text(
                              weight.toString(),
                              style: TextStyle(
                                fontSize: isSelected ? 28.sp : 22.sp,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? AppColors.kOrange : AppColors.kGray,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: -10.h,
                    child: Icon(
                      Icons.arrow_drop_up,
                      color: AppColors.kOrange,
                      size: 24.h,
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              SizedBox(height: 20.h),
              CustomButton(
                text: isFromEditProfile ? "Done" : "Next",
                onPressed: () async {
                  if (isFromEditProfile) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('edit_profile_weight', '$selectedWeight KG');
                    Navigator.pop(context);
                  } else {
                    signupProvider.saveData("weight", selectedWeight.toString());
                    Navigator.pushReplacementNamed(context, PageRouteName.heightScreen);
                  }
                },
                color: AppColors.kOrange,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}