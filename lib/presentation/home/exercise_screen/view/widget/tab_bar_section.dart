import 'package:fitness_app/presentation/home/exercise_screen/view/widget/shimmer_video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../../../domain/entity/exercise/difficulty_level_entity.dart';
import '../../view_model/exercise_state.dart';
import '../../view_model/exercise_view_model.dart';
import 'exercise_list.dart';

class TabBarSection extends StatefulWidget {
  const TabBarSection({super.key});

  @override
  State<TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection>
    with TickerProviderStateMixin {
  late ExerciseViewModel levelViewModel;
  late ExerciseViewModel exerciseViewModel;
  TabController? _tabController;
  bool _isInitialized = false;

  late String id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    id = args['id'] as String;
    if (!_isInitialized) {
      _isInitialized = true;
      levelViewModel = getIt.get<ExerciseViewModel>();
      exerciseViewModel = getIt.get<ExerciseViewModel>();

      levelViewModel.getAllLevelsBuMuscleId(id);
    }
  }

  void _initTabController(
      List<DifficultyLevelEntity?> levels, String muscleId) {
    _tabController = TabController(length: levels.length, vsync: this);

    _tabController!.addListener(() {
      final index = _tabController!.index;
      final levelId = levels[index]?.id;
      if (levelId != null &&
          exerciseViewModel.state is! ExerciseByMuscleLevelLoadingState) {
        exerciseViewModel.getExerciseByMuscleAndLevel(muscleId, levelId);
      }
    });

    final firstLevelId = levels[0]?.id;
    if (firstLevelId != null) {
      exerciseViewModel.getExerciseByMuscleAndLevel(muscleId, firstLevelId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseViewModel, ExerciseState>(
      bloc: levelViewModel,
      builder: (context, state) {
        if (state is LevelsByMuscleLoadingState) {
          return _buildTabsShimmerLoading();
        } else if (state is LevelsByMuscleErrorState) {
          return Center(
            child: Text(
              state.errorMessage ?? 'An error occurred',
              style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        } else if (state is LevelsByMuscleSuccessState) {
          final levels = state.level ?? [];
          final muscleId = id;

          if (levels.isEmpty) {
            return Center(
              child: Text(
                'No levels found',
                style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          if (_tabController == null) {
            _initTabController(levels, muscleId);
          }

          return DefaultTabController(
            length: levels.length,
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  // isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  indicator: BoxDecoration(
                    color: AppColors.kOrange,
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  tabs: levels
                      .map((level) => Tab(
                            height: 36.h,
                            text: level?.name,
                          ))
                      .toList(),
                  dividerColor: Colors.transparent,
                ),
                Expanded(
                  child: BlocBuilder<ExerciseViewModel, ExerciseState>(
                    bloc: exerciseViewModel,
                    builder: (context, exerciseState) {
                      if (exerciseState is ExerciseByMuscleLevelLoadingState) {
                        return ShimmerVideoCardList();
                      } else if (exerciseState
                          is ExerciseByMuscleLevelSuccessState) {
                        final exercises = exerciseState.exercise ?? [];
                        if (exercises.isEmpty) {
                          return const Center(
                            child: Text(
                              'No exercises found for this level',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return ExerciseList(exercises: exercises);
                      } else if (exerciseState
                          is ExerciseByMuscleLevelErrorState) {
                        return Center(
                          child: Text(
                            exerciseState.errorMessage ?? 'An error occurred',
                            style: TextStyle(
                              color: AppColors.kWhite,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: Text(
                          'Select a difficulty level to view exercises',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}

Widget _buildTabsShimmerLoading() {
  return Column(
    children: [
      SizedBox(
        height: 40.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ShimmerLoadingWidget(
                width: 90.w,
                height: 20.h,
                borderRadius: 20.r,
              ),
            );
          },
        ),
      ),
      const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.kOrange,
          ),
        ),
      ),
    ],
  );
}
