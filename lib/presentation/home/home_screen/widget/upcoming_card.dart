import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../../domain/entity/home/random_muscle_entity.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

//get all prime mover muscle
class UpcomingCard extends StatefulWidget {
  const UpcomingCard({super.key, required this.muscleGroupId});

  final String muscleGroupId;

  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  late HomeCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    viewModel.getMuscleGroupById(widget.muscleGroupId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is MuscleGroupIdLoading || state is GetMuscleLoading) {
          return _buildShimmerTabs();
        } else if (state is MuscleGroupIdError) {
          return Center(
            child: Text("Error: ${state.errorMessage}",
                style: TextStyle(color: AppColors.kWhite)),
          );
        } else if (state is MuscleGroupIdSuccess) {
          List<MuscleEntity?> muscleGroups = state.muscleEntity ?? [];
          if (muscleGroups.isEmpty || muscleGroups.every((m) => m == null)) {
            return Center(
              child: Text("No Data Available",
                  style: TextStyle(color: AppColors.kWhite, fontSize: 16)),
            );
          }
          return SizedBox(
          //  width: 110.w,
            height: 110.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: muscleGroups.length,
              itemBuilder: (context, index) {
                final muscle = muscleGroups[index];
                if (muscle == null) {
                  return Center(
                    child: Text("No Data Available",
                        style:
                            TextStyle(color: AppColors.kWhite, fontSize: 14)),
                  );
                }

                return buildCardWidget(muscle.name ?? "",
                    muscle.image ?? "https://placehold.co/90x90");
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 15.w);
              },
            ),
          );
        }

        return Center(
          child: Text("waiting data...",
              style: TextStyle(color: AppColors.kWhite)),
        );
      },
    );
  }

  Widget buildCardWidget(String title, String imagePath) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              imagePath,
              width: 90.w,
              height: 110.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return ShimmerLoadingWidget(
                  width: 90.w,
                  height: 90.h,
                  borderRadius: 20.r,
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.kMainColor.withOpacity(0.5),
                  AppColors.kMainColor.withOpacity(0.8),
                ],
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerTabs() {
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: ShimmerLoadingWidget(
              width: 90.w,
              height: 90.h,
              borderRadius: 20.r,
            ),
          );
        },
      ),
    );
  }
}
