import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';

class ProfileImageWidget extends StatelessWidget {
  final String profileImageUrl;
  final String firstName;
  final String lastName;

  const ProfileImageWidget({
    super.key,
    required this.profileImageUrl,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipOval(
            child: profileImageUrl.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: profileImageUrl,
              fit: BoxFit.cover,
              height: 100.h,
              width: 100.w,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset(
                AppImages.person,
                height: 100.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            )
                : Image.asset(
              AppImages.person,
              height: 100.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "$firstName $lastName",
            style: AppFonts.font20WhiteWeight800,
          )
        ],
      ),
    );
  }
}