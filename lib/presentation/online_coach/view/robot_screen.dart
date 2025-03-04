import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/widget/custom_arrow.dart';

class RobotScreen extends StatelessWidget {
  const RobotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.backgroundRobot,
      overlayOpacity: 0.1,
      enableBlur: true,
      blurStrength: 6.0,
      blurHeight: 170.0.h,
      blurWidth: 350.0.w,
      borderRadius: 30.0.r,
      blurStartPosition: MediaQuery.of(context).size.height * 0.65,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomArrow(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hi",
                          style: AppFonts.font16WhiteWeight500,
                        ),
                        Text("  Rawan,", style: AppFonts.font16WhiteWeight500)
                      ],
                    ),
                    Text("I Am Your Smart Coach",
                        style: AppFonts.font16WhiteWeight500
                            .copyWith(fontSize: 18.sp)),
                  ],
                ),
                Image.asset(AppImages.menuIcon),
              ],
            ),
            20.verticalSpace,
            Image.asset(AppImages.robot),
            Center(
              child: Text(
                "How Can I Assist You      Today?",
                style: AppFonts.font24WhiteWeight800,
                textAlign: TextAlign.center,
              ),
            ),
            CustomButton(
              width: 300.w,
              onPressed: (){
                Navigator.pushReplacementNamed(context, PageRouteName.chatScreen);
              },
              text: "Get Started",
              textStyle: AppFonts.font14WhiteWeight800,
            )
          ],
        ),
      ),
    );
  }
}
