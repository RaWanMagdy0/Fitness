import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:fitness_app/presentation/home/home_screen/widget/upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/functions/dialogs/app_dialogs.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../../data/models/workout/muscle_model.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

//get all muscle group
class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  _CategoryTabsState createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int selectedIndex = 0;
  late HomeCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    viewModel.getMuscleGroups();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is GetMuscleLoading) {
          return _buildShimmerTabs();
        } else if (state is GetMuscleError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              AppDialogs.showErrorDialog(
                context: context,
                errorMassage: state.errorMessage,
              );
            }
          });
        } else if (state is GetMuscleSuccess) {
          List<MuscleGroup> muscleGroups = state.muscleGroups;
          return Column(
            children: [
              SizedBox(
                height: 30.h,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: muscleGroups.length,
                    itemBuilder: (context, index) {
                      bool isSelected = index == selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.kOrange : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            muscleGroups[index].name ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildShimmerTabs() {
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: ShimmerLoadingWidget(
              width: 80.w,
              height: 25.h,
              borderRadius: 25.r,
            ),
          );
        },
      ),
    );
  }
}
