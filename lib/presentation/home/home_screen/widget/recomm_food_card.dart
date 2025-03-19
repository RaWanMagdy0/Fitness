import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/widget/custom_cached_network_image.dart';
import '../../../../core/utils/widget/shimmer_loading_widget.dart';
import '../../../../data/models/meal/meals_tabs_response_model.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_state.dart';

class RecommFoodCard extends StatefulWidget {
  const RecommFoodCard({super.key});

  @override
  State<RecommFoodCard> createState() => _RecommFoodCardState();
}

class _RecommFoodCardState extends State<RecommFoodCard> {
  late HomeCubit viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeCubit>();
    viewModel.fetchMealsTabs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is MealsTabsLoading) {
          return _buildCustomShimmer();
        } else if (state is MealsTabsError) {
          return Center(
            child: Text(
              "Error: ${state.errorMessage}",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        } else if (state is MealsTabsSuccess) {
          List<Categories> categories = state.categories;

          return SizedBox(
            height: 140.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return buildCardWidget(
                  context,
                  categories[index].strCategory ?? "",
                  categories[index].strCategoryThumb ?? "",
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 15.w);
              },
            ),
          );
        }

        return Container();
      },
    );
  }
  Widget _buildCustomShimmer() {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ShimmerLoadingWidget(
              width: 110.w,
              height: 110.h,
              borderRadius: 20.r,
            ),
          );
        },
      ),
    );
  }

  Widget buildCardWidget(BuildContext context, String title, String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return SizedBox.shrink();
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PageRouteName.mealsScreen,
          arguments: title,
        );
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child:
              CustomCachedNetworkImage(
                imageUrl: imagePath,
                width: 110.w,
                height: 110.h,
                shimmerRadiusValue: 0,
                fit: BoxFit.cover,
                shimmerHeight:110.h,
                shimmerWidth: 110.w,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.kMainColor.withOpacity(0.5),
                    AppColors.kMainColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
