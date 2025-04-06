import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view/widget/tab_bar_section.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view_model/exercise_state.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view_model/exercise_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/widget/custom_arrow.dart';
import '../../../../core/utils/widget/custom_cached_network_image.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late ExerciseViewModel viewModel;
  String title = 'Default Title';
  String imagePath = '';
  String level = 'Beginner';
  String url = 'url';
  String primaryEquipment = 'primaryEquipment';
  String bodyRegion = 'bodyRegion';

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ExerciseViewModel>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (arguments != null) {
      title = arguments['title'] ?? 'Default Title';
      imagePath = arguments['imagePath'] ?? '';
      level = arguments['level'] ?? 'Beginner';
      url = arguments['url'] ?? 'url';
      bodyRegion = arguments['bodyRegion'] ?? 'bodyRegion';
      primaryEquipment = arguments['primaryEquipment'] ?? 'primaryEquipment';
    }
    viewModel.getExercise();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseViewModel, ExerciseState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is ExerciseLoadingState) {
          return Center(
            child: Lottie.asset(AppImages.loadingAnimation),
          );
        } else if (state is ExerciseErrorState) {
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
        } else if (state is ExerciseSuccessState) {
          if (state.exercise.isEmpty) {
            return CustomScaffold(
              backgroundImage: AppImages.homeBackG,
              child: Center(
                child: Text(
                  "There are no exercises currently available.",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return CustomScaffold(
            backgroundImage: AppImages.homeBackG,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300.h,
                      child: CustomCachedNetworkImage(
                        imageUrl: imagePath.isEmpty
                            ? AppImages.chestExerciseImage
                            : imagePath,
                        width: double.infinity,
                        height: 300.h,
                        shimmerRadiusValue: 0,
                        fit: BoxFit.cover,
                        shimmerHeight: 300.h,
                        shimmerWidth: 400.w,
                      ),
                    ),
                    Positioned(
                      top: 16.h,
                      left: 16.w,
                      child: CustomArrow(),
                    ),
                    Positioned(
                      bottom: 0.h,
                      left: 0.w,
                      right: 0.w,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.kMainColor.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                title,
                                style: AppFonts.font24WhiteWeight600,
                                textAlign: TextAlign.center,
                              ),
                              8.verticalSpace,
                              Text(
                                "Body Region :$bodyRegion ",
                                style: const TextStyle(fontSize: 14, color: Colors.white70),
                              ),
                              Text(
                                "primary equipment for this exercise :$primaryEquipment ",
                                style: const TextStyle(fontSize: 14, color: Colors.white70),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(18.w, 40.h),
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                        side: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.w,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      level,
                                      style: AppFonts.font12OrangeWeight400,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => _launchURL(url),
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
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: TabBarSection(exercises: state.exercise),
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

  void _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      return;
    }
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {}
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
