import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../../../../generated/l10n.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeight();
  }

  Future<void> _loadWeight() async {
    try {
      final signupProvider = context.read<SignupProvider>();
      setState(() {
        selectedWeight =
            int.tryParse(signupProvider.getData("weight") ?? '') ?? 50;
        _isLoading = false;
      });
      _scrollToSelectedWeight();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
    final signupProvider = context.read<SignupProvider>();

    return WillPopScope(
      onWillPop: () async {
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
        child: _isLoading
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
                          onTap: () {
                            Navigator.pushNamed(
                                context, PageRouteName.ageScreen);
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
                    Center(
                      child: ProgressIndicatorWidget(
                          currentPage: 3, totalPages: 6),
                    ),
                    30.verticalSpace,
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
                    20.verticalSpace,
                    SizedBox(height: 80.h),
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
                    15.verticalSpace,
                    SizedBox(height: 20.h),
                    CustomButton(
                      text: local.next,
                      onPressed: () {
                        signupProvider.saveData(
                            "weight", selectedWeight.toString());
                        Navigator.pushReplacementNamed(
                            context, PageRouteName.heightScreen);
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
