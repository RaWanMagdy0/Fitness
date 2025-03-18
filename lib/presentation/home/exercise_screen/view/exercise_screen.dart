import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view/widget/tab_bar_section.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view_model/exercise_state.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view_model/exercise_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/widget/custom_arrow.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}
class _ExerciseScreenState extends State<ExerciseScreen> {
  late ExerciseViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<ExerciseViewModel>();
    viewModel.getExercise();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseViewModel,ExerciseState>(
      bloc:viewModel,
        builder: (context,state) {
          if (state is ExerciseLoadingState) {
            return Center(
              child: Lottie.asset(AppImages.loadingAnimation),
            );
          } else if (state is ExerciseErrorState) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred',style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),),
            );
          }
          else if (state is ExerciseSuccessState) {
            if (state.exercise.isEmpty) {
              return CustomScaffold(
                backgroundImage: AppImages.homeBackG,
                child: Center(
                  child: Text(
                    "There are no exercises currently available.",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return CustomScaffold(
              backgroundImage: AppImages.homeBackG,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 350.h,
                        child: Image.asset(
                          AppImages.chestExerciseImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 16.h,
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
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Chest Exercise",
                                  style: AppFonts.font24WhiteWeight600,
                                  textAlign: TextAlign.center,
                                ),
                                8.verticalSpace,
                                Text(
                                  "Lorem ipsum dolor sit amet consectetur. Tempus volutpat ut nisi morbi.",
                                  textAlign: TextAlign.center,
                                  style: AppFonts.font16WhiteWeight500,
                                ),
                                8.verticalSpace,

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(18.w, 40.h),
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              50.r),
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.w,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "30 MIN" ?? '',
                                        style: AppFonts.font12OrangeWeight400,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(18.w, 40.h),
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              50.r),
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.w,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "120 cal" ?? '',
                                        style: AppFonts.font12OrangeWeight400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      child: TabBarSection(exercises: state.exercise),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }
    );
  }}