import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/presentation/profile/view/widgets/custom_profile_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../core/di/di.dart';
import '../../../core/generated/l10n.dart';
import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/images/app_images.dart';
import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});
  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  late ProfileCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ProfileCubit>();
    viewModel.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: viewModel,
        builder: (context, state) {
          if (state is GetUserDataLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.loadingAnimation),
            );
          } else if (state is GetUserDataErrorState) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred'),
            );
          } else if (state is GetUserDataSuccessState) {
            return CustomScaffold(
              backgroundImage: AppImages.splashBackG,
              enableBlur: true,
              blurStrength: 6.0,
              blurHeight: 320.0.h,
              blurWidth: 350.0.w,
              borderRadius: 30.0,
              overlayOpacity: 0.7,
              color: Color(0xFF242424).withOpacity(0.6),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Image.asset(AppImages.back),
                          100.horizontalSpace,
                          Center(
                              child: Text(
                            "Profile",
                            style: AppFonts.font24WhiteWeight600,
                          )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Image.network(
                            state.user?.photo ?? AppImages.person,
                            fit: BoxFit.cover,
                            height: 100.h,
                            width: 100.w,
                            errorBuilder: (_, __, ___) =>
                                Image.asset(AppImages.person),
                          ),
                        ),
                        15.verticalSpace,
                        Text(
                          "${state.user?.firstName} ${state.user?.lastName}",
                          style: AppFonts.font20WhiteWeight800,
                        )
                      ],
                    ),
                    70.verticalSpace,
                    CustomProfileRow(
                      imagePath: AppImages.personIcon,
                      title: "edit profile",
                      onTap: () => Navigator.pushNamed(
                          context, PageRouteName.editProfileScreen),
                    ),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    CustomProfileRow(
                        imagePath: AppImages.changeIcon,
                        title: "change password"),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    CustomProfileRow(
                        imagePath: AppImages.languageIcon,
                        title: "select language"),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    CustomProfileRow(
                        imagePath: AppImages.securityIcon, title: "Security"),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    CustomProfileRow(
                        imagePath: AppImages.privacyIcon,
                        title: "Privacy Policy"),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    CustomProfileRow(
                        imagePath: AppImages.helpIcon, title: "Help"),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    CustomProfileRow(
                        imagePath: AppImages.logoutIcon, title: "Logout"),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}
