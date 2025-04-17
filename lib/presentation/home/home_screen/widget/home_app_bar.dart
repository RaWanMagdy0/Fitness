import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/di/di.dart';
import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late ProfileCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: viewModel,
      builder: (context, state) {
        final userName = viewModel.userName;
        final userImage = viewModel.userImage;
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
                      Text("Hi ", style: AppFonts.font16WhiteWeight500),
                      const SizedBox(width: 2),
                      Text(userName ?? "Rowan",
                          style: AppFonts.font16WhiteWeight500),
                      Text(",", style: AppFonts.font16WhiteWeight500),
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
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return _buildShimmerEffect();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(AppImages.chestExerciseImage);
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      child: ShimmerLoadingWidget(
        height: 60,
        width: 60,
        borderRadius: 50.r,
      ),
    );
  }
}
