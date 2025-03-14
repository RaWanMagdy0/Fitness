import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/functions/dialogs/app_dialogs.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/presentation/workout/view/widgets/muscle_card.dart';
import 'package:fitness_app/presentation/workout/view_model/workout_cubit.dart';
import 'package:fitness_app/presentation/workout/view_model/workout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/di/di.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../data/models/workout/muscle_model.dart';
import 'widgets/category_chip.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late WorkoutCubit _workoutCubit;
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _workoutCubit = getIt<WorkoutCubit>();
    _workoutCubit.getMuscleGroups();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.homeBackG,
      child: BlocProvider.value(
        value: _workoutCubit,
        child: BlocConsumer<WorkoutCubit, WorkoutState>(
          listener: (context, state) {
            if (state is GetMuscleGroupsError) {
              AppDialogs.showErrorDialog(
                context: context,
                errorMassage: state.errorMessage ?? "Failed to load muscle groups",
              );
            } else if (state is GetMuscleDetailsError) {
              AppDialogs.showErrorDialog(
                context: context,
                errorMassage: state.errorMessage ?? "Failed to load muscle details",
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Text(
                    "Workouts",
                    style: AppFonts.font24WhiteWeight600,
                  ),
                ),

                // Category Chips
                _buildCategoryChips(state),

                // Muscle Grid
                Expanded(
                  child: _buildMuscleGrid(state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryChips(WorkoutState state) {
    if (state is GetMuscleGroupsLoading) {
      return SizedBox(
        height: 50.h,
        child: Center(
          child: SizedBox(
            width: 40.w,
            height: 40.h,
            child: CircularProgressIndicator(
              color: AppColors.kOrange,
            ),
          ),
        ),
      );
    } else if (state is GetMuscleGroupsSuccess ||
        (state is GetMuscleDetailsSuccess && _workoutCubit.selectedMuscleGroupId != null)) {
      List<MuscleGroup> muscleGroups = [];

      if (state is GetMuscleGroupsSuccess) {
        muscleGroups = state.muscleGroups;
      } else if (state is GetMuscleDetailsSuccess &&
          _workoutCubit.state is GetMuscleGroupsSuccess) {
        muscleGroups = (_workoutCubit.state as GetMuscleGroupsSuccess).muscleGroups;
      }

      return SizedBox(
        height: 50.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            // "Full Body" special category
            CategoryChip(
              label: "Full Body",
              isSelected: selectedCategoryId == null,
              onTap: () {
                setState(() {
                  selectedCategoryId = null;
                });
                _workoutCubit.getMuscleGroups();
              },
            ),

            ...muscleGroups.map((group) {
              return CategoryChip(
                label: group.getEnglishName(),
                isSelected: selectedCategoryId == group.id,
                onTap: () {
                  setState(() {
                    selectedCategoryId = group.id;
                  });
                  _workoutCubit.getMuscleGroupDetails(group.id!);
                },
              );
            }),
          ],
        ),
      );
    }

    return SizedBox(height: 50.h);
  }

  Widget _buildMuscleGrid(WorkoutState state) {
    if (state is GetMuscleGroupsLoading || state is GetMuscleDetailsLoading) {
      return Center(
        child: Lottie.asset(
          AppImages.loadingAnimation,
          width: 100.w,
          height: 100.h,
        ),
      );
    } else if (state is GetMuscleGroupsSuccess) {
      final muscleGroups = state.muscleGroups;

      return GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.0,
        ),
        itemCount: muscleGroups.length,
        itemBuilder: (context, index) {
          final group = muscleGroups[index];
          return MuscleCard(
            title: group.getEnglishName(),
            imagePath: "https://iili.io/33p7y9p.png", // Default image
            onTap: () {
              if (group.id != null) {
                _workoutCubit.getMuscleGroupDetails(group.id!);
                setState(() {
                  selectedCategoryId = group.id;
                });
              }
            },
          );
        },
      );
    } else if (state is GetMuscleDetailsSuccess) {
      final muscleDetail = state.response;
      final muscles = muscleDetail.muscles ?? [];

      if (muscles.isEmpty) {
        return Center(
          child: Text(
            "No exercises found for this muscle group",
            style: AppFonts.font16WhiteWeight500,
            textAlign: TextAlign.center,
          ),
        );
      }

      return GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.0,
        ),
        itemCount: muscles.length,
        itemBuilder: (context, index) {
          final muscle = muscles[index];
          return MuscleCard(
            title: muscle.getEnglishName(),
            imagePath: muscle.image ?? "https://iili.io/33p7y9p.png",
            onTap: () {
            },
          );
        },
      );
    } else if (state is GetMuscleGroupsError || state is GetMuscleDetailsError) {
      String errorMessage = "Something went wrong";
      if (state is GetMuscleGroupsError) {
        errorMessage = state.errorMessage ?? errorMessage;
      } else if (state is GetMuscleDetailsError) {
        errorMessage = state.errorMessage ?? errorMessage;
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.kError,
              size: 48.sp,
            ),
            16.verticalSpace,
            Text(
              errorMessage,
              style: AppFonts.font16WhiteWeight500,
              textAlign: TextAlign.center,
            ),
            16.verticalSpace,
            ElevatedButton(
              onPressed: () {
                if (state is GetMuscleGroupsError) {
                  _workoutCubit.getMuscleGroups();
                } else if (state is GetMuscleDetailsError && _workoutCubit.selectedMuscleGroupId != null) {
                  _workoutCubit.getMuscleGroupDetails(_workoutCubit.selectedMuscleGroupId!);
                } else {
                  _workoutCubit.getMuscleGroups();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text(
                "Try Again",
                style: AppFonts.font14WhiteWeight600,
              ),
            ),
          ],
        ),
      );
    }

    // Default state (WorkoutInitial)
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.kOrange,
      ),
    );
  }
}