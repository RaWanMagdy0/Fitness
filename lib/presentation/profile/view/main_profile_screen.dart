import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/core/utils/widget/shimmer_loading_widget.dart';
import 'package:fitness_app/presentation/profile/view/widgets/custom_profile_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/di/di.dart';
import '../../../core/routes/page_route_name.dart';
import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../core/utils/functions/providers/local_provider.dart';
import '../../../generated/l10n.dart';
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
    var provider = Provider.of<LocalProvider>(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
        bloc: viewModel,
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            AppDialogs.showHideDialog(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              PageRouteName.login,
              (route) => false,
            );
          } else if (state is LogoutErrorState) {
            AppDialogs.showHideDialog(context);
            AppDialogs.showErrorDialog(
              context: context,
              errorMassage: state.message ?? "Logout failed",
            );
          }
        },
        builder: (context, state) {
          if (state is GetUserDataLoadingState) {
            return _buildShimmerProfile(context, local, provider);
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
                            local.profile,
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
                      title: Text(
                        local.edit_profile,
                        style: AppFonts.font14WhiteWeight600,
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, PageRouteName.editProfileScreen),
                    ),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, PageRouteName.changePassword);
                      },
                      child: CustomProfileRow(
                          imagePath: AppImages.changeIcon,
                          title: Text(
                            local.change_password,
                            style: AppFonts.font14WhiteWeight600,
                          )),
                    ),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    CustomProfileRow(
                        imagePath: AppImages.languageIcon,
                        title: Row(
                          children: [
                            Text(
                              local.select_language,
                              style: AppFonts.font14WhiteWeight600,
                            ),
                            110.horizontalSpace,
                            InkWell(
                                onTap: () {
                                  provider.changeLanguage(
                                      provider.locale == "en" ? "ar" : "en");
                                },
                                child: Text(
                                  provider.locale == "en"
                                      ? "(Arabic)"
                                      : "(English)",
                                  style: AppFonts.font15OrangeWeight500,
                                ))
                          ],
                        )),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, PageRouteName.security);

                      },
                      child: CustomProfileRow(
                          imagePath: AppImages.securityIcon,
                          title: Text(
                            local.security,
                            style: AppFonts.font14WhiteWeight600,
                          )),
                    ),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PageRouteName.privacyPolicyScreen);
                      },
                      child: CustomProfileRow(
                          imagePath: AppImages.privacyIcon,
                          title: Text(
                            local.privacy_policy,
                            style: AppFonts.font14WhiteWeight600,
                          )),
                    ),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, PageRouteName.help);

                      },
                      child: CustomProfileRow(
                          imagePath: AppImages.helpIcon,
                          title: Text(
                            local.help,
                            style: AppFonts.font14WhiteWeight600,
                          )),
                    ),
                    SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        )),
                    InkWell(
                      onTap: () {
                        AppDialogs.logoutDialog(
                            context: context, profileCubit: viewModel);
                      },
                      child: CustomProfileRow(
                          imagePath: AppImages.logoutIcon,
                          title: Text(
                            local.logout,
                            style: AppFonts.font14WhiteWeight600,
                          )),
                    ),
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

  Widget _buildShimmerProfile(
      BuildContext context, S local, LocalProvider provider) {
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
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Image.asset(AppImages.back),
                  100.horizontalSpace,
                  Center(
                    child: Text(
                      local.profile,
                      style: AppFonts.font24WhiteWeight600,
                    ),
                  ),
                ],
              ),
            ),

            // Profile image and name shimmer
            Column(
              children: [
                // Profile image shimmer
                ShimmerLoadingWidget(
                  width: 100.w,
                  height: 100.h,
                  borderRadius: 50.r, // Circle shape
                ),
                15.verticalSpace,
                // Name shimmer
                ShimmerLoadingWidget(
                  width: 150.w,
                  height: 24.h,
                  borderRadius: 4.r,
                ),
              ],
            ),

            70.verticalSpace,

            // Menu items shimmer
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.0.w),
              child: Column(
                children: List.generate(
                  7,
                  (index) => Column(
                    children: [
                      Row(
                        children: [
                          // Icon shimmer
                          ShimmerLoadingWidget(
                            width: 24.w,
                            height: 24.h,
                            borderRadius: 4.r,
                          ),
                          15.horizontalSpace,
                          // Text shimmer
                          ShimmerLoadingWidget(
                            width: 200.w,
                            height: 18.h,
                            borderRadius: 4.r,
                          ),
                          Spacer(),
                          // Arrow shimmer
                          ShimmerLoadingWidget(
                            width: 16.w,
                            height: 16.h,
                            borderRadius: 2.r,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 350.0.w,
                        child: Divider(
                          color: AppColors.kGray,
                        ),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
