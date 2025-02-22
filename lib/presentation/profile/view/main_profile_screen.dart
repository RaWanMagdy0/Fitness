import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/presentation/profile/view/widgets/custom_profile_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/images/app_images.dart';
import '../../../core/routes/page_route_name.dart' show PageRouteName;

class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.splashBackG,
      enableBlur: true,
      blurStrength: 6.0,
      blurHeight: 350.0.h,
      blurWidth: 350.0.w,
      borderRadius: 30.0,
        overlayOpacity: 0.7,
        color: Color(0xFF242424).withOpacity(0.6),
   //   blurStartPosition: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Image.asset(AppImages.back),
                  110.horizontalSpace,
                  Center(
                      child: Text(
                    "Profile",
                    style: AppFonts.font24WhiteWeight600,
                  )),
                ],
              ),
            ),
            Column(
              children: [
                ClipOval(child: Image.asset(AppImages.person)),
                Text(
                  "Rawan Magdy",
                  style: AppFonts.font20WhiteWeight800,
                )
              ],
            ),
            50.verticalSpace,
            CustomProfileRow(
              icon: Icons.person,
              title: "edit profile",
              onTap: () => Navigator.pushNamed(context, PageRouteName.editProfileScreen),
            ),
            SizedBox(
              width: 350.0.w,
                child: Divider(color: AppColors.kGray,)),
            CustomProfileRow(icon: Icons.person, title: "change password"),
            SizedBox(
                width: 350.0.w,
                child: Divider(color: AppColors.kGray,)),
            CustomProfileRow(icon: Icons.language, title: "select language"),
            SizedBox(
                width: 350.0.w,
                child: Divider(color: AppColors.kGray,)),
            CustomProfileRow(icon: Icons.person, title: "Security"),
            SizedBox(
                width: 350.0.w,
                child: Divider(color: AppColors.kGray,)),
            CustomProfileRow(icon: Icons.person, title: "Privacy Policy"),
            SizedBox(
                width: 350.0.w,
                child: Divider(color: AppColors.kGray,)),
            CustomProfileRow(icon: Icons.help_outline_sharp, title: "Help"),
            SizedBox(
                width: 350.0.w,
                child: Divider(color: AppColors.kGray,)),
            CustomProfileRow(icon: Icons.logout, title: "Logout"),
            SizedBox(
                width: 350.0.w,
                child: Divider(color: AppColors.kGray,)),
          ],
        ),
      ),
    );
  }
}
