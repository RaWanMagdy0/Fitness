import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view/widget/tab_bar_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/widget/custom_arrow.dart';
import '../../../../core/utils/widget/custom_cached_network_image.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late String id;
  late String image;
  late String name;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    id = args['id'] as String;
    image = args['imagePath'] as String;
    name = args['title'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.backgroundRobot,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300.h,
                    child: CustomCachedNetworkImage(
                      imageUrl: image,
                      width: double.infinity,
                      height: 300.h,
                      shimmerRadiusValue: 0,
                      fit: BoxFit.cover,
                      shimmerHeight: 300.h,
                      shimmerWidth: 400.w,
                    ),
                  ),
                  Positioned(
                    top: 50.h,
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: AppFonts.font24WhiteWeight600,
                            textAlign: TextAlign.center,
                          ),
                          8.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              Expanded(
                child: TabBarSection(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
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
      print("Error: YouTube URL is empty");
      return null;
    }
    print("YouTube URL: $url");
    String? videoId;
    if (url.contains("youtube.com/watch?v=")) {
      videoId = Uri.parse(url).queryParameters['v'];
    } else if (url.contains("youtu.be/")) {
      videoId = url.split("youtu.be/")[1].split("?")[0];
    } else if (url.contains("youtube.com/embed/")) {
      videoId = url.split("embed/")[1].split("?")[0];
    }
    if (videoId == null || videoId.isEmpty) {
      print("Error: Video ID is not extracted correctly.");
      return null;
    }
    print("Video ID: $videoId");
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }
}
