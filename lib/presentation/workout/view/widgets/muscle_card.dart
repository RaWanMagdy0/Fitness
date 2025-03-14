import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors/app_colors.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';

class MuscleCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const MuscleCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.kBlackBG.withOpacity(0.7),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              placeholder: (context, url) => ShimmerLoadingWidget(
                width: double.infinity,
                height: double.infinity,
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.kGray.withOpacity(0.3),
                child: Icon(
                  Icons.fitness_center,
                  color: AppColors.kLightGrey,
                  size: 50.sp,
                ),
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // Title at the bottom
            Positioned(
              bottom: 12.h,
              left: 12.w,
              right: 12.w,
              child: Text(
                title,
                style: AppFonts.font14WhiteWeight600,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}