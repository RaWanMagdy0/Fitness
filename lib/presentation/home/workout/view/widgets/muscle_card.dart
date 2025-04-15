import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/presentation/home/workout/view_model/workout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/styles/colors/app_colors.dart';
import '../../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../view_model/workout_cubit.dart';

class MuscleCard extends StatefulWidget {
  const MuscleCard({super.key, required this.muscleGroupId});

  final String muscleGroupId;

  @override
  State<MuscleCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<MuscleCard> {
  late WorkoutCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<WorkoutCubit>();
    viewModel.getMuscleGroupDetails(widget.muscleGroupId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is GetMuscleDetailsLoading) {
          return _buildShimmerTabs();
        } else if (state is GetMuscleDetailsError) {
          return Center(
            child: Text("Error: ${state.errorMessage}",
                style: TextStyle(color: AppColors.kWhite)),
          );
        } else if (state is GetMuscleDetailsSuccess) {
          final muscleDetails = state.response.muscles;
          return SizedBox(
            height: 650.h,
            child: (muscleDetails == null || muscleDetails.isEmpty)
                ? Center(
                    child: Text(
                      "No Data Available",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: muscleDetails.length,
                    itemBuilder: (context, index) {
                      final muscle = muscleDetails[index];

                      if (muscle.name == null ||
                          muscle.image == null) {
                        return Center(
                          child: Text(
                            "No Data Available",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        );
                      }

                      return buildCardWidget(muscle.name!, muscle.image!,muscle.id!);
                    },
                  ),
          );
        }

        return Center(
          child: Text("Waiting for data...",
              style: TextStyle(color: AppColors.kWhite)),
        );
      },
    );
  }

  Widget buildCardWidget(String title, String imagePath,String id) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, PageRouteName.exerciseScreen, arguments: {
          "id":id,
          "imagePath":imagePath,
          "title":title,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imagePath,
                width: double.infinity,
                height: 160.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ShimmerLoadingWidget(
                    width: double.infinity,
                    height: 160.h,
                    borderRadius: 16.r,
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
