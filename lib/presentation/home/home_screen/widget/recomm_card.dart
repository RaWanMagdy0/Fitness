import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/widget/custom_cached_network_image.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../../domain/entity/home/random_muscle_entity.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

//get 20 random

class RecommCard extends StatefulWidget {
  const RecommCard({super.key});

  @override
  State<RecommCard> createState() => _RecommCardState();
}

class _RecommCardState extends State<RecommCard> {
  late HomeCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    viewModel.getRandomMuscle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is RandomMuscleLoading) {
          return _buildShimmerLoading();
        } else if (state is RandomMuscleError) {
          return SizedBox.shrink();
        } else if (state is RandomMuscleSuccess) {
          List<MuscleEntity?>? muscleEntity = state.muscleEntity;

          return SizedBox(
            height: 140.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: muscleEntity?.length ?? 4,
              itemBuilder: (context, index) {
                return buildCardWidget(
                  muscleEntity?[index]?.name ?? "",
                  muscleEntity?[index]?.image ?? "",
                  muscleEntity?[index]?.id ?? "",
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 15.w);
              },
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _buildShimmerLoading() {
    return SizedBox(
      height: 140.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return ShimmerLoadingWidget(
            width: 110.w,
            height: 110.h,
            borderRadius: 20.r,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 15.w);
        },
      ),
    );
  }

  Widget buildCardWidget(
    String title,
    String? imagePath,
    String id,
  ) {
    if (imagePath == null || imagePath.isEmpty) {
      return SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          PageRouteName.exerciseScreen,
          arguments: {
            "id":id,
            "imagePath":imagePath,
            "title":title,
          });
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CustomCachedNetworkImage(
                imageUrl: imagePath,
                width: 110.w,
                height: 110.h,
                shimmerRadiusValue: 0,
                fit: BoxFit.cover,
                shimmerHeight: 110.h,
                shimmerWidth: 110.w,
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
      ),
    );
  }
}

