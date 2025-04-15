import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/presentation/home/workout/view/widgets/muscle_card.dart';
import 'package:fitness_app/presentation/home/workout/view_model/workout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../view_model/workout_cubit.dart';
import 'widgets/category_chip.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late WorkoutCubit viewModel;
  String selectedMuscleGroupId = "";

  @override
  void initState() {
    super.initState();
    viewModel = getIt<WorkoutCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        backgroundImage: AppImages.homeBackG,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                "Workouts",
                style: AppFonts.font24WhiteWeight600,
              ),
            ),
            15.verticalSpace,
            CategoryChip(
              onTabSelected: (muscleGroupId) {
                if (selectedMuscleGroupId != muscleGroupId) {
                  setState(() {
                    selectedMuscleGroupId = muscleGroupId;
                  });
                  viewModel.getMuscleGroupDetails(muscleGroupId);
                }
              },
            ),
            20.verticalSpace,
            if (selectedMuscleGroupId.isNotEmpty)
              BlocBuilder<WorkoutCubit, WorkoutState>(
                bloc: viewModel,
                builder: (context, state) {
                  if (state is GetMuscleDetailsLoading) {
                    return _buildShimmerTabs();
                  } else if (state is GetMuscleDetailsError) {
                    return Center(child: Text("Error: ${state.errorMessage}"));
                  } else if (state is GetMuscleDetailsSuccess) {
                    return MuscleCard(muscleGroupId: selectedMuscleGroupId);
                  }
                  return Container();
                },
              ),
          ],
        ));
  }

  Widget _buildShimmerTabs() {
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: ShimmerLoadingWidget(
              width: 170.w,
              height: 170.h,
              borderRadius: 20.r,
            ),
          );
        },
      ),
    );
  }
}
