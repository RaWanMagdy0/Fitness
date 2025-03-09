part of 'meal_details_cubit.dart';

enum DifficultyLevel { beginner, intermediate, advanced }

abstract class MealDetailsState {}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsSuccess extends MealDetailsState {
  final Meal meal;
  final DifficultyLevel selectedDifficulty;

  MealDetailsSuccess({
    required this.meal,
    this.selectedDifficulty = DifficultyLevel.beginner,
  });
}

class MealDetailsError extends MealDetailsState {
  final String errorMessage;

  MealDetailsError({required this.errorMessage});
}