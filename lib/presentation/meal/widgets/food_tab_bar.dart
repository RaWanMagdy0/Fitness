import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final List<String> tabNames;

  const FoodTabBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.tabNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabNames.length, (index) {
            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: _buildTab(index, tabNames[index]),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.white30),
        ),
        child: Text(
          title,
          style: isSelected
              ? AppFonts.font12WhiteWeight700
              : AppFonts.font12WhiteWeight700.copyWith(color: Colors.white70),
        ),
      ),
    );
  }
}
