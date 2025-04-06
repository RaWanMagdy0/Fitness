import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';

class EditProfileShimmer extends StatelessWidget {
  const EditProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(AppImages.back),
              SizedBox(width: 85.w),
              ShimmerLoadingWidget(
                width: 120.w,
                height: 30.h,
                borderRadius: 4.r,
              ),
            ],
          ),

          SizedBox(height: 30.h),

          // Profile image and name shimmer
          Center(
            child: Column(
              children: [
                // Profile image shimmer
                ShimmerLoadingWidget(
                  width: 100.w,
                  height: 100.h,
                  borderRadius: 50.r, // Circle shape
                ),
                SizedBox(height: 10.h),
                // Name shimmer
                ShimmerLoadingWidget(
                  width: 150.w,
                  height: 24.h,
                  borderRadius: 4.r,
                ),
              ],
            ),
          ),

          SizedBox(height: 30.h),

          // Form fields shimmer
          Column(
            children: [
              // First Name field
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 50.h,
                borderRadius: 25.r,
              ),
              SizedBox(height: 16.h),

              // Last Name field
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 50.h,
                borderRadius: 25.r,
              ),
              SizedBox(height: 16.h),

              // Email field
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 50.h,
                borderRadius: 25.r,
              ),
              SizedBox(height: 50.h),

              // Custom fields (Weight, Goal, Activity)
              _buildCustomFieldShimmer(),
              SizedBox(height: 8.h),
              _buildCustomFieldShimmer(),
              SizedBox(height: 8.h),
              _buildCustomFieldShimmer(),
              SizedBox(height: 32.h),

              // Save button
              ShimmerLoadingWidget(
                width: double.infinity,
                height: 45.h,
                borderRadius: 50.r,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomFieldShimmer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShimmerLoadingWidget(
            width: 120.w,
            height: 18.h,
            borderRadius: 4.r,
          ),
          ShimmerLoadingWidget(
            width: 80.w,
            height: 18.h,
            borderRadius: 4.r,
          ),
        ],
      ),
    );
  }
}