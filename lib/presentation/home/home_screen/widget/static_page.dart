import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/images/app_images.dart';

class StaticPage extends StatelessWidget {
  final String iconPath;

  const StaticPage({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 200.w,
            height: 200.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20),
          Text(
            'Exciting Features Coming Soon!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Stay tuned for updates and new experiences.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kOrange,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, PageRouteName.chatScreen);
            },
            child: Text(
              'Try Gemini AI',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
