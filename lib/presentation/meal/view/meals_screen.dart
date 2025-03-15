import 'package:fitness_app/core/styles/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../core/styles/images/app_images.dart';
import '../../../core/utils/widget/custom scaffold.dart';
import '../../../core/utils/widget/shimmer_loading_widget.dart';
import '../view_model/meal_details_cubit.dart';
import '../view_model/meal_state.dart';
import '../view_model/meals_view_model.dart';
import '../widgets/food_tab_bar.dart';
import '../../../data/models/meal/meals_tabs_response_model.dart';
import 'meal_details_screen.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({Key? key}) : super(key: key);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  int _selectedTabIndex = 0;
  late MealsViewModel _viewModel;
  List<Categories> _allCategories = [];
  bool _initialFetchDone = false;

  @override
  void initState() {
    super.initState();
    _viewModel = GetIt.I<MealsViewModel>();
    _fetchCategories();
  }

  void _fetchCategories() async {
    await _viewModel.fetchMealsTabs();
    if (_viewModel.state is MealsTabsSuccess) {
      final categories = (_viewModel.state as MealsTabsSuccess).categories;
      if (categories.isNotEmpty) {
        setState(() {
          _allCategories = categories;
        });
        // Only fetch meals once during initial load
        if (!_initialFetchDone) {
          _fetchMeals(categories.first.strCategory ?? '');
          _initialFetchDone = true;
        }
      }
    }
  }

  void _fetchMeals(String category) {
    _viewModel.fetchMealsByCategory(category);
  }

  void _onTabSelected(int index) {
    if (_selectedTabIndex != index) {
      setState(() {
        _selectedTabIndex = index;
      });
      _fetchMeals(_allCategories[index].strCategory ?? '');
    }
  }

  Widget _buildTabsShimmerLoading() {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show 5 tab placeholders
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ShimmerLoadingWidget(
              width: 80.w,
              height: 35.h,
              borderRadius: 20.r,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealsShimmerLoading() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 163 / 160,
      ),
      itemCount: 6, // Show 6 meal placeholders
      itemBuilder: (context, index) {
        return ShimmerLoadingWidget(
          width: 163.w,
          height: 160.h,
          borderRadius: 20.r,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.homeBackG,
      overlayOpacity: 0.1,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(AppImages.back),
                  ),
                  SizedBox(width: 30.w),
                  Text(
                    'Food Recommendation',
                    style: AppFonts.font24WhiteWeight600.copyWith(fontSize: 22),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              // Tab bar with shimmer effect
              BlocBuilder<MealsViewModel, MealsScreenState>(
                bloc: _viewModel,
                builder: (context, state) {
                  if (state is MealsTabsLoading) {
                    return _buildTabsShimmerLoading();
                  } else if (state is MealsTabsError) {
                    return Column(
                      children: [
                        Text(
                          'Failed to load categories',
                          style: AppFonts.font16WhiteWeight500,
                        ),
                        SizedBox(height: 8.h),
                        ElevatedButton(
                          onPressed: _fetchCategories,
                          child: const Text('Retry'),
                        ),
                      ],
                    );
                  } else if (_allCategories.isNotEmpty) {
                    return FoodTabBar(
                      selectedIndex: _selectedTabIndex,
                      onTabSelected: _onTabSelected,
                      tabNames: _allCategories
                          .map((cat) => cat.strCategory ?? 'Unknown')
                          .toList(),
                    );
                  }
                  return const SizedBox(height: 48);
                },
              ),
              SizedBox(height: 24.h),
              // Meals grid with shimmer effect
              Expanded(
                child: BlocBuilder<MealsViewModel, MealsScreenState>(
                  bloc: _viewModel,
                  builder: (context, state) {
                    if (state is MealsLoading) {
                      return _buildMealsShimmerLoading();
                    } else if (state is MealsSuccess) {
                      if (state.meals.isEmpty) {
                        return Center(
                            child: Text('No meals found in this category',
                                style: AppFonts.font16WhiteWeight500));
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 163 / 160,
                        ),
                        itemCount: state.meals.length,
                        itemBuilder: (context, index) {
                          final meal = state.meals[index];
                          // Inside MealsScreen class, update the GestureDetector's onTap in the GridView.builder:

                          // 1. Update your navigation code in MealsScreen:

                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (_) => GetIt.I<MealDetailsCubit>(),
                                  child: MealDetailsScreen(
                                    mealId: meal.idMeal ?? '',
                                  ),
                                ),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.network(
                                      meal.strMealThumb ?? '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[800],
                                          child: const Center(
                                            child: Icon(
                                              Icons.restaurant,
                                              color: Colors.white54,
                                              size: 48,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        color: Colors.black.withOpacity(0.5),
                                        child: Text(
                                          meal.strMeal ?? '',
                                          style: AppFonts.font16WhiteWeight700,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is MealsError) {
                      return Center(
                        child: Text('Error loading meals',
                            style: AppFonts.font16WhiteWeight500),
                      );
                    } else {
                      return _buildMealsShimmerLoading();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
