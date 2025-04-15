import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/presentation/home/home_screen/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/widget/custom_cached_network_image.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
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
            return _buildShimmerTabs();
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
            // تصفية التمارين التي تحتوي على رابط فارغ أو null
            final exercises = state.exercise?.where((exercise) {
              // تجاهل التمارين التي تحتوي على رابط فارغ أو null
              return exercise?.inDepthYoutubeExplanationLink?.isNotEmpty ?? false;
            }).toList();

            return SizedBox(
              height: 160.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: exercises?.length ?? 0,
                itemBuilder: (context, index) {
                  final exercise = exercises![index];
                  String? thumbnailUrl = getYoutubeThumbnail(
                      exercise?.shortYoutubeDemonstrationLink);

                  return buildCardWidget(
                      context,
                      exercise?.exercise ?? "",
                      thumbnailUrl ?? "",
                      exercise?.difficultyLevel ?? "",
                      exercise?.inDepthYoutubeExplanationLink ?? "");
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
              width: 250.w,
              height: 150.h,
              borderRadius: 20.r,
            ),
          );
        },
      ),
    );
  }

  Widget buildCardWidget(BuildContext context, String title, String imagePath,
      String level, String inDepthYoutubeExplanationLink) {
    return Container(
      width: 250.w,
      height: 400.h,
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
              height: 400.h,
              width: 400.w,
              shimmerRadiusValue: 0,
              fit: BoxFit.cover,
              shimmerHeight: 360.h,
              shimmerWidth: 400.w,
            ),
          ),
          Container(
            width:double.infinity,
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
                    Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: AppColors.kMainColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        level,
                        style: AppFonts.font12OrangeWeight400.copyWith(
                          color: AppColors.kOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _launchURL(inDepthYoutubeExplanationLink),
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.kOrange,
                        ),
                        child: const Center(
                          child: Icon(Icons.play_arrow,
                              color: Colors.black, size: 30),
                        ),
                      ),
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

  void _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      print("Error: URL is empty or null");
      return;
    }

    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Error: Cannot launch URL");
    }
  }

  String? getYoutubeThumbnail(String? url) {
    if (url == null || url.isEmpty) {
      print("Error: YouTube URL is empty or null");
      return null;
    }

    String? videoId;
    if (url.contains("youtube.com/watch?v=")) {
      videoId = Uri.parse(url).queryParameters['v'];
    } else if (url.contains("youtu.be/")) {
      videoId = url.split("youtu.be/")[1].split("?")[0];
    } else if (url.contains("youtube.com/embed/")) {
      videoId = url.split("embed/")[1].split("?")[0];
    }

    if (videoId == null || videoId.isEmpty) {
      print("Error: Video ID extraction failed");
      return null;
    }

    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
}
