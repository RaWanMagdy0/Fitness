import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom_arrow.dart';
import 'package:fitness_app/core/utils/widget/shimmer_loading_widget.dart';
import 'package:fitness_app/presentation/meal/view_model/meal_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/styles/images/app_images.dart';

class MealDetailsScreen extends StatefulWidget {
  final String mealId;

  const MealDetailsScreen({
    super.key,
    required this.mealId,
  });

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<MealDetailsCubit>().getMealDetails(widget.mealId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
      BlocBuilder<MealDetailsCubit, MealDetailsState>(
        builder: (context, state) {
          if (state is MealDetailsLoading) {
            return _buildLoadingShimmer();
          } else if (state is MealDetailsError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: AppFonts.font16WhiteWeight500,
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is MealDetailsSuccess) {
            final meal = state.meal;
            final nutritionalInfo = meal.getNutritionalInfo();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with image
                Stack(
                  children: [
                    // Meal Image
                    SizedBox(
                      width: double.infinity,
                      height: 300.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                        child: Image.network(
                          meal.strMealThumb ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppColors.kGray,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: AppColors.kWhite,
                                size: 50.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Back button
                    Positioned(
                      top: 40.h,
                      left: 16.w,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const CustomArrow(),
                      ),
                    ),

                    // Gradient overlay at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal.strMeal ?? 'Meal Name',
                              style: AppFonts.font20WhiteWeight800,
                            ),
                            5.verticalSpace,
                            Text(
                              "${meal.strCategory ?? 'Category'} • ${meal.strArea ?? 'Area'}",
                              style: AppFonts.font14WhiteWeight400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                10.verticalSpace,

                // Nutritional info
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNutritionItem(
                        "${nutritionalInfo.energy} K",
                        "Energy",
                        AppColors.kOrange,
                      ),
                      _buildNutritionItem(
                        "${nutritionalInfo.protein} G",
                        "Protein",
                        AppColors.kOrange,
                      ),
                      _buildNutritionItem(
                        "${nutritionalInfo.carbs} G",
                        "Carbs",
                        AppColors.kOrange,
                      ),
                      _buildNutritionItem(
                        "${nutritionalInfo.fat} G",
                        "Fat",
                        AppColors.kOrange,
                      ),
                    ],
                  ),
                ),

                16.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.kOrange,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.kOrange,
                    unselectedLabelColor: AppColors.kLightGrey,
                    tabs: const [
                      Tab(text: "Description"),
                      Tab(text: "Video"),
                      Tab(text: "Ingredients"),
                    ],
                  ),
                ),

                10.verticalSpace,

                // Tab content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Description Tab
                      _buildDescriptionTab(meal),

                      // Video Tab
                      _buildVideoTab(meal),

                      // Ingredients Tab
                      _buildIngredientsTab(meal),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    ]));
  }

  Widget _buildLoadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Image shimmer
            ShimmerLoadingWidget(
              width: double.infinity,
              height: 250.h,
              borderRadius: 0,
            ),

            // Back button
            Positioned(
              top: 16.h,
              left: 16.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const CustomArrow(),
              ),
            ),

            // Title shimmer
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoadingWidget(
                    width: 200.w,
                    height: 24.h,
                    borderRadius: 4.r,
                  ),
                  SizedBox(height: 5.h),
                  ShimmerLoadingWidget(
                    width: 150.w,
                    height: 16.h,
                    borderRadius: 4.r,
                  ),
                ],
              ),
            ),
          ],
        ),

        10.verticalSpace,

        // Nutrition info shimmer
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => ShimmerLoadingWidget(
                width: 70.w,
                height: 50.h,
                borderRadius: 20.r,
              ),
            ),
          ),
        ),

        16.verticalSpace,

        // Difficulty level tabs shimmer
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => ShimmerLoadingWidget(
                width: 100.w,
                height: 35.h,
                borderRadius: 20.r,
              ),
            ),
          ),
        ),

        16.verticalSpace,

        // Tab bar shimmer
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ShimmerLoadingWidget(
            width: double.infinity,
            height: 40.h,
            borderRadius: 4.r,
          ),
        ),

        10.verticalSpace,

        // Tab content shimmer
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: ListView.separated(
              itemCount: 8,
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemBuilder: (context, index) => ShimmerLoadingWidget(
                width: double.infinity,
                height: 20.h,
                borderRadius: 4.r,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionItem(String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.kBlackBG.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppFonts.font14WhiteWeight600.copyWith(
              color: AppColors.kWhite,
            ),
          ),
          Text(
            label,
            style: AppFonts.font12OrangeWeight400.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionTab(final meal) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Text(
        meal.strInstructions ?? 'No description available',
        style: AppFonts.font14WhiteWeight400,
      ),
    );
  }

  Widget _buildVideoTab(final meal) {
    final videoUrl = meal.strYoutube;

    if (videoUrl == null || videoUrl.isEmpty) {
      return Center(
        child: Text(
          'No video available',
          style: AppFonts.font16WhiteWeight500,
        ),
      );
    }

    final videoId = _getYoutubeVideoId(videoUrl);
    if (videoId == null) {
      return Center(
        child: Text(
          'Invalid YouTube URL',
          style: AppFonts.font16WhiteWeight500,
        ),
      );
    }
    final String embeddedVideoHtml = '''
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body { margin: 0; padding: 0; background-color: #000; overflow: hidden; }
          #player { position: absolute; width: 100%; height: 100%; top: 0; left: 0; }
        </style>
      </head>
      <body>
        <div id="player"></div>
        <script>
          var tag = document.createElement('script');
          tag.src = "https://www.youtube.com/iframe_api";
          var firstScriptTag = document.getElementsByTagName('script')[0];
          firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
          
          var player;
          function onYouTubeIframeAPIReady() {
            player = new YT.Player('player', {
              videoId: '$videoId',
              playerVars: {
                'autoplay': 1,
                'playsinline': 1,
                'rel': 0,
                'showinfo': 0,
                'controls': 1,
                'modestbranding': 1
              },
              events: {
                'onReady': onPlayerReady
              }
            });
          }
          
          function onPlayerReady(event) {
            event.target.playVideo();
          }
        </script>
      </body>
    </html>
  ''';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              height: 270.h,
              child: InAppWebView(
                initialData: InAppWebViewInitialData(
                  data: embeddedVideoHtml,
                  mimeType: 'text/html',
                  encoding: 'utf-8',
                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    mediaPlaybackRequiresUserGesture: false,
                    useOnLoadResource: true,
                    javaScriptEnabled: true,
                    useShouldOverrideUrlLoading: true,
                  ),
                ),
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final uri = navigationAction.request.url;
                  final host = uri?.host ?? '';

                  if (host.contains('youtube.com') ||
                      host.contains('youtu.be')) {
                    return NavigationActionPolicy.CANCEL;
                  }

                  return NavigationActionPolicy.ALLOW;
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                },
              ),
            ),
          ),
          10.verticalSpace,
          ElevatedButton.icon(
            onPressed: () => _openYoutubeVideo(videoId),
            icon: Icon(
              Icons.play_circle_outline,
              color: AppColors.kWhite,
            ),
            label: Text(
              'Watch On YouTube',
              style: TextStyle(color: AppColors.kWhite),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kOrange,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openYoutubeVideo(String videoId) async {
    final urls = [
      'youtube://www.youtube.com/watch?v=$videoId', // YouTube app
      'https://www.youtube.com/watch?v=$videoId', // HTTPS
      'https://youtu.be/$videoId',
    ];

    bool launched = false;
    for (final url in urls) {
      try {
        final Uri uri = Uri.parse(url);
        launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (launched) break;
      } catch (e) {
        print('Error launching $url: $e');
      }
    }
    if (!launched) {
      try {
        final Uri uri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
        await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
          ),
        );
      } catch (e) {
        print('Final fallback error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Could not open video. Please try again later.')),
        );
      }
    }
  }

  String? _getYoutubeVideoId(String url) {
    RegExp regExp = RegExp(
      r'(?:youtube\.com\/(?:[^\/\n\s]+\/\s*[^\/\n\s]+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
    );

    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  Widget _buildIngredientsTab(final meal) {
    final ingredients = meal.getIngredientsWithMeasures();

    if (ingredients.isEmpty) {
      return Center(
        child: Text(
          'No ingredients available',
          style: AppFonts.font16WhiteWeight500,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ingredient.ingredient,
                style: AppFonts.font14LightOrangeWeight400
                    .copyWith(color: AppColors.kLightGrey),
              ),
              Text(
                ingredient.measure,
                style: AppFonts.font14LightOrangeWeight400,
              ),
            ],
          ),
        );
      },
    );
  }
}
