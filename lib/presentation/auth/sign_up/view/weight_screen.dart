import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/local/sign_up_provider.dart';
import '../../../../core/routes/page_route_name.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
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
  @override
  void initState() {
    super.initState();
    final signupProvider = context.read<SignupProvider>();
    selectedWeight = int.tryParse(signupProvider.getData("weight") ?? '') ?? 50;
  }

  @override
  Widget build(BuildContext context) {
    final local=S.of(context);
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
                    Navigator.pushNamed(context, PageRouteName.ageScreen);
                  },
                  child: Image.asset(AppImages.back),
                ),
                100.horizontalSpace,
                Image.asset(AppImages.logoIcon),
              ],
            ),
            40.verticalSpace,
            Center(
                child: ProgressIndicatorWidget(currentPage: 3, totalPages: 6)),
            30.verticalSpace,
            Text(
              local.what_is_your_weight,
              style: AppFonts.font14WhiteWeight800.copyWith(fontSize: 20),
            ),
            Text(
              local.this_helps_us_create_Your_personalized_plan,
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
                  local.kg,
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
                  bottom: -10,
                  child: Icon(Icons.arrow_drop_up,
                      color: AppColors.kOrange, size: 24),
                ),
              ],
            ),
            40.verticalSpace,
            CustomButton(
              text: local.next,
              onPressed: () {
                signupProvider.saveData("weight", selectedWeight.toString());

                Navigator.pushReplacementNamed(
                    context, PageRouteName.heightScreen);
              },
              color: AppColors.kOrange,
            )
          ],
        ),
      ),
    );
  }
}
