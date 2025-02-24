import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/styles/images/app_images.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeLayout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.homeBackground,
      blurStrength: 20.0,
      borderRadius: 30.0,
      child: Stack(
        children: [
          Center(
            child: Text(
              "Selected Index: $_selectedIndex",
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 24.h,
            right: 30.w,
            left: 30.w,
            child: Container(
              height: 74.h,
              width: 310.w,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage("assets/images/Frame 76.png"),
                      size: 35.sp,
                      color: _selectedIndex == 0
                          ? Colors.deepOrange
                          : Colors.white,
                    ),
                    label: _selectedIndex == 0 ? 'Explore' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage("assets/images/Frame 77.png"),
                      size: 35.sp,
                      color: _selectedIndex == 1
                          ? Colors.deepOrange
                          : Colors.white,
                    ),
                    label: _selectedIndex == 1 ? 'Chat ai' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage("assets/images/workoutIcon.png"),
                      size: 35.sp,
                      color: _selectedIndex == 2
                          ? Colors.deepOrange
                          : Colors.white,
                    ),
                    label: _selectedIndex == 2 ? 'Workout' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      const AssetImage("assets/images/profileIcon.png"),
                      size: 35.sp,
                      color: _selectedIndex == 3
                          ? Colors.deepOrange
                          : Colors.white,
                    ),
                    label: _selectedIndex == 3 ? 'Profile' : '',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
