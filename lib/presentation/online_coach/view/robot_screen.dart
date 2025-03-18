import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/core/utils/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/styles/colors/app_colors.dart';
import '../../../core/utils/widget/custom_arrow.dart';
import '../../profile/view_model/profile_cubit.dart';
import '../../profile/view_model/profile_state.dart';
import '../widget/object_box.dart';

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
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final cubit = context.watch<ProfileCubit>();
                        if (state is ProfileInitialState) {
                          cubit.getUserData();
                        }
                        final userName = cubit.userName;
                        return Row(
                          children: [
                            Text("Hi", style: AppFonts.font16WhiteWeight500),
                            2.horizontalSpace,
                            Text(userName ?? "Rowan",
                                style: AppFonts.font16WhiteWeight500),
                            Text(",", style: AppFonts.font16WhiteWeight500),
                          ],
                        );
                      },
                    ),
                    Text("I Am Your Smart Coach",
                        style: AppFonts.font16WhiteWeight500
                            .copyWith(fontSize: 18.sp)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    openPreviousChats(context);
                  },
                  child: Image.asset(AppImages.menuIcon),
                ),
              ],
            ),
            20.verticalSpace,
            Image.asset(AppImages.robot),
            Center(
              child: Text(
                "How Can I Assist You Today?",
                style: AppFonts.font24WhiteWeight800,
                textAlign: TextAlign.center,
              ),
            ),
            CustomButton(
              width: 300.w,
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, PageRouteName.chatScreen);
              },
              text: "Get Started",
              textStyle: AppFonts.font14WhiteWeight800,
            )
          ],
        ),
      ),
    );
  }

  void openPreviousChats(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final objectBox = context.read<ObjectBox>();
        List<String> previousConversations = objectBox.getChatTitles();
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kMainColor.withOpacity(0.8),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r)),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              height: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Previous Conversations",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  10.verticalSpace,
                  Expanded(
                    child: ListView.separated(
                      itemCount: previousConversations.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.white24, thickness: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: Icon(Icons.arrow_back_ios,
                                color: AppColors.kOrange),
                            title: Text(
                              previousConversations[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PageRouteName.chatScreen,
                                arguments: previousConversations[index],
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
