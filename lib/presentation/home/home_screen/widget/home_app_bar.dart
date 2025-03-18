import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.watch<ProfileCubit>();
        if (state is ProfileInitialState) {
          cubit.getUserData();
        }
        final userName = cubit.userName;
        final userImage = cubit.userImage;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Hi ",
                          style: AppFonts.font16WhiteWeight500),
                      const SizedBox(width: 2),
                      Text(userName ?? "Rowan",
                          style: AppFonts.font16WhiteWeight500),
                      Text(",",
                          style: AppFonts.font16WhiteWeight500),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text("Let's Start Your Day",
                      style: AppFonts.font18WhiteWeight400),
                ],
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: userImage == null
                    ? _buildShimmerEffect()
                    : ClipOval(
                  child: Image.network(
                    userImage,
                    fit: BoxFit.cover,
                    loadingBuilder:
                        (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return _buildShimmerEffect();
                    },
                    errorBuilder:
                        (context, error, stackTrace) {
                      return Image.asset(
                          AppImages.chestExerciseImage);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    )
    ;
  }
  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Color(0xFFEEEEEE),
      highlightColor: Color(0xFFD9D9D9),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

}
