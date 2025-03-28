import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';
import '../../../profile/view_model/profile_cubit.dart';
import '../../../profile/view_model/profile_state.dart';

class HomeAppBar extends StatefulWidget {
  final ProfileCubit profileCubit;

  const HomeAppBar({super.key, required this.profileCubit});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late ProfileCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.profileCubit;
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
