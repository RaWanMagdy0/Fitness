import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../domain/entity/exercise/exercise_entity.dart';
import 'exercise_list.dart';

class TabBarSection extends StatelessWidget {
  final List<Exercise?> exercises;
  TabBarSection({super.key, required this.exercises});
  final List<String> levels = ["Beginner", "Intermediate", "Advanced"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: levels.length,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: AppColors.kOrange,
              borderRadius: BorderRadius.circular(25),
            ),
            tabs: levels.map((level) => Tab(text: level)).toList(),
          ),
          10.verticalSpace,
          SizedBox(
            height: 400,
            child: TabBarView(
              children: levels.map((level) {
                final filteredExercises = exercises.where((e) => e?.difficultyLevel == level).toList();
                return ExerciseList(exercises: filteredExercises);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
