import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../generated/l10n.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';

class EditProfileWeightScreen extends StatefulWidget {
  const EditProfileWeightScreen({super.key});

  @override
  State<EditProfileWeightScreen> createState() => _EditProfileWeightScreenState();
}

class _EditProfileWeightScreenState extends State<EditProfileWeightScreen> {
  int selectedWeight = 70;
  final int minWeight = 30;
  final int maxWeight = 200;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeight();
  }

  Future<void> _loadWeight() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentWeight = prefs.getString('current_weight');

      if (currentWeight != null) {
        setState(() {
          selectedWeight = int.tryParse(currentWeight) ?? 70;
          _isLoading = false;
        });
        _scrollToSelectedWeight();
        return;
      }

      // Get weight from profile data
      final profileCubit = getIt<ProfileCubit>();
      final state = profileCubit.state;

      if (state is GetUserDataSuccessState && state.user != null) {
        setState(() {
          selectedWeight = state.user?.weight ?? 70;
          _isLoading = false;
        });
        _scrollToSelectedWeight();
        return;
      }

      await profileCubit.getUserData();
      await Future.delayed(const Duration(milliseconds: 300));

      final newState = profileCubit.state;
      if (newState is GetUserDataSuccessState && newState.user != null) {
        setState(() {
          selectedWeight = newState.user?.weight ?? 70;
          _isLoading = false;
        });
        _scrollToSelectedWeight();
        return;
      }

      // Default fallback
      setState(() {
        _isLoading = false;
      });
      _scrollToSelectedWeight();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _scrollToSelectedWeight();
    }
  }

  void _scrollToSelectedWeight() {
    if (_scrollController.hasClients) {
      final itemWidth = 30.0.w;
      final screenWidth = MediaQuery.of(context).size.width;
      final centerPosition = (selectedWeight - minWeight) * itemWidth -
          (screenWidth / 2) +
          itemWidth;

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
    final local = S.of(context);

    return WillPopScope(
      onWillPop: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('edit_profile_weight', "$selectedWeight KG");
        return true;
      },
      child: CustomScaffold(
        backgroundImage: AppImages.authBackground,
        enableBlur: true,
        blurStrength: 5.0,
        blurHeight: 230.h,
        blurWidth: 430.w,
        borderRadius: 50.r,
        blurStartPosition: MediaQuery.of(context).size.height * 0.32,
        child: _isLoading
            ? Center(child: CircularProgressIndicator(color: AppColors.kOrange))
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('edit_profile_weight', "$selectedWeight KG");
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      AppImages.back,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              120.verticalSpace,
              Text(
                local.what_is_your_weight,
                style: AppFonts.font14WhiteWeight800
                    .copyWith(fontSize: 20.sp),
              ),
              Text(
                local.this_helps_us_create_Your_personalized_plan,
                style: AppFonts.font18WhiteWeight400
                    .copyWith(fontSize: 15.sp),
              ),
              0.verticalSpace,
              SizedBox(height: 60.h),
              Center(
                child: Text(
                  'Kg',
                  style: TextStyle(
                    color: AppColors.kOrange,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(height: 21.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 60,
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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              weight.toString(),
                              style: TextStyle(
                                fontSize: isSelected ? 28 : 22,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? AppColors.kOrange
                                    : AppColors.kGray,
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
              20.verticalSpace,
              SizedBox(height: 10.h),
              CustomButton(
                text: local.done,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('edit_profile_weight', "$selectedWeight KG");
                  Navigator.pop(context);
                },
                color: AppColors.kOrange,
              ),
              30.verticalSpace,
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