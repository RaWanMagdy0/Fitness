import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeLayout extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeLayout({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 300.w,
      decoration: BoxDecoration(
        color: AppColors.bottomNavColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: onTap,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/Frame 76.png"),
              size: 35.sp,
              color: currentIndex == 0 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/Frame 77.png"),
              size: 35.sp,
              color: currentIndex == 1 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Chat AI',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/workoutIcon.png"),
              size: 35.sp,
              color: currentIndex == 2 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage("assets/images/profileIcon.png"),
              size: 35.sp,
              color: currentIndex == 3 ? Colors.deepOrange : Colors.white,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
