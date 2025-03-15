import '../../../data/models/meal/meals_response_model.dart';
import '../../../data/models/meal/meals_tabs_response_model.dart';
import '../../../data/models/meal/meal_model.dart';

sealed class MealsScreenState {}

class MealsScreenInitial extends MealsScreenState {}

//tabs States
class MealsTabsLoading extends MealsScreenState {}

class MealsTabsSuccess extends MealsScreenState {
  final List<Categories> categories;

  MealsTabsSuccess({required this.categories});
}

class MealsTabsError extends MealsScreenState {
  final String errorMessage;

  MealsTabsError({required this.errorMessage});
}

//meals States
class MealsLoading extends MealsScreenState {}

class MealsSuccess extends MealsScreenState {
  final List<Meals> meals;

  MealsSuccess({required this.meals});
}

class MealsError extends MealsScreenState {
  final String errorMessage;

  MealsError({required this.errorMessage});
}
