import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom scaffold.dart';
import '../../../../core/utils/widget/custom_button.dart';
import '../widgets/custom_indecator.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final int minHeight = 120;
  final int maxHeight = 210;

  int selectedHeight = 90;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final signupProvider = context.read<SignupProvider>();
    selectedHeight = int.tryParse(signupProvider.getData("height") ?? '') ?? 170;
  }
  @override
  Widget build(BuildContext context) {
    final signupProvider = context.read<SignupProvider>();

    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 230,
      blurWidth: 430,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.36,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageRouteName.weightScreen);
                  },
                  child: Image.asset(AppImages.back),
                ),
                100.horizontalSpace,
                Image.asset(AppImages.logoIcon),
              ],
            ),
            40.verticalSpace,
            Center(
                child: ProgressIndicatorWidget(currentPage: 4, totalPages: 6)),
            30.verticalSpace,
            Text(
              "what is your height?",
              style: AppFonts.font14WhiteWeight800.copyWith(fontSize: 20),
            ),
            Text(
              "this helps us create Your personalized plan",
              style: AppFonts.font18WhiteWeight400.copyWith(fontSize: 15),
            ),
            20.verticalSpace,
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                    "CM",
                    style: AppFonts.font12OrangeWeight400
                ),
              ),),
            5.verticalSpace,
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: maxHeight - minHeight + 1,
                    itemBuilder: (context, index) {
                      int weight = minHeight + index;
                      bool isSelected = weight == selectedHeight;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedHeight = weight;
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
                  bottom: -10,
                  child: Icon(Icons.arrow_drop_up,
                      color:  AppColors.kOrange, size: 24),
                ),
              ],
            ),
            40.verticalSpace,
            CustomButton(
              text: "Next",
              onPressed: () {
                signupProvider.saveData("height", selectedHeight.toString());

                Navigator.pushReplacementNamed(
                    context, PageRouteName.goalScreen);
              },
              color: AppColors.kOrange,
            )
          ],
        ),
      ),
    );
  }
}
