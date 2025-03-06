import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/styles/colors/app_colors.dart';
import 'exercise_list.dart';

class TabBarSection extends StatelessWidget {
  final List<String> levels = ["Beginner", "Intermediate", "Advanced"];

  TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: levels.length,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(vertical: 7.h),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: AppColors.kOrange,
              borderRadius: BorderRadius.circular(25.r),
            ),
            tabs: levels.map((level) => Tab(text: level)).toList(),
          ),
          10.verticalSpace,
          SizedBox(
            height: 400.h,
            child: TabBarView(
              children: List.generate(3, (index) => ExerciseList()),
            ),
          ),
        ],
      ),
    );
  }
}