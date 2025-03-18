import '../../../../data/models/meal/meals_tabs_response_model.dart';
import '../../../../data/models/workout/muscle_model.dart';
import '../../../../domain/entity/home/random_muscle_entity.dart';

abstract class HomeState {}

class WorkoutInitial extends HomeState {}

class GetMuscleLoading extends HomeState {}
//get muscles tab
class GetMuscleSuccess extends HomeState {
  final List<MuscleGroup> muscleGroups;

  GetMuscleSuccess({required this.muscleGroups});
}

class GetMuscleError extends HomeState {
  final String errorMessage;

  GetMuscleError({required this.errorMessage});
}
class MuscleDetailsSuccess extends HomeState {
  final List<Muscle> muscle;

  MuscleDetailsSuccess({
    required this.muscle,
  });
}

class MuscleDetailsError extends HomeState {
  final String? errorMessage;

  MuscleDetailsError({this.errorMessage});
}

//get meals recommendation
class MealsTabsLoading extends HomeState {}

class MealsTabsSuccess extends HomeState {
  final List<Categories> categories;

  MealsTabsSuccess({required this.categories});
}

class MealsTabsError extends HomeState {
  final String errorMessage;

  MealsTabsError({required this.errorMessage});
}

//get random muscle
class RandomMuscleLoading extends HomeState {}

class RandomMuscleSuccess extends HomeState {
  final List<MuscleEntity?>? muscleEntity;

  RandomMuscleSuccess({required this.muscleEntity});
}

class RandomMuscleError extends HomeState {
  final String errorMessage;

  RandomMuscleError({required this.errorMessage});
}

//get  muscle group by id
class MuscleGroupIdLoading extends HomeState {}

class MuscleGroupIdSuccess extends HomeState {
  final List<MuscleEntity?>? muscleEntity;

  MuscleGroupIdSuccess({required this.muscleEntity});
}

class MuscleGroupIdError extends HomeState {
  final String errorMessage;

  MuscleGroupIdError({required this.errorMessage});
}

