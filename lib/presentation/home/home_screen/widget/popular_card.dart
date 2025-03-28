import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/presentation/home/home_screen/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/di/di.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/custom_cached_network_image.dart';
import '../view_model/home_cubit.dart';

class PopularCard extends StatefulWidget {
  const PopularCard({super.key});

  @override
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  late HomeCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    viewModel.getExercise();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is HomeExerciseLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.loadingAnimation),
            );
          } else if (state is HomeExerciseErrorState) {
            return Center(
              child: Text(
                state.errorMessage ?? 'An error occurred',
                style: TextStyle(
                    color: AppColors.kWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ),
            );
          } else if (state is HomeExerciseSuccessState) {
            return SizedBox(
              height: 160.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount:
                    state.exercise!.isNotEmpty ? state.exercise!.length : 4,
                itemBuilder: (context, index) {
                  if (state.exercise!.isNotEmpty) {
                    final exercise = state.exercise![index];
                    String? thumbnailUrl = getYoutubeThumbnail(
                        exercise?.shortYoutubeDemonstrationLink);

                    return buildCardWidget(exercise?.exercise ?? "",
                        thumbnailUrl!, exercise?.difficultyLevel ?? '');
                  }
                  return buildCardWidget("Exercises That Strengthen Your Chest",
                      AppImages.runningImage, "Beginner");
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 15.w);
                },
              ),
            );
          }
          return Container();
        });
  }

  String? getYoutubeThumbnail(String? url) {
    if (url == null) return null;
    String? videoId;
    if (url.contains("youtube.com/watch?v=")) {
      videoId = Uri.parse(url).queryParameters['v'];
    } else if (url.contains("youtu.be/")) {
      videoId = url.split("youtu.be/")[1].split("?")[0];
    } else if (url.contains("youtube.com/embed/")) {
      videoId = url.split("embed/")[1].split("?")[0];
    }
    if (videoId == null || videoId.isEmpty) return null;
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
}

Widget buildCardWidget(String title, String imagePath, String level) {
  return Container(
    width: 180.w,
    height: 150.h,
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
            width: 180.w,
            height: 150.h,
            shimmerRadiusValue: 0,
            fit: BoxFit.fitHeight,
            shimmerHeight: 150.h,
            shimmerWidth: 180.w,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTag("10 Tasks", isOrange: true),
                  _buildTag(
                    level,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTag(String text, {bool isOrange = false}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
    decoration: BoxDecoration(
      color: AppColors.kMainColor.withOpacity(0.9),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Text(
      text,
      style: AppFonts.font12OrangeWeight400.copyWith(
        color: isOrange ? AppColors.kWhite : AppColors.kOrange,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
