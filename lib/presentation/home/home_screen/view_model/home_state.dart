import '../../../../data/models/workout/muscle_model.dart';

abstract class HomeState {}

class WorkoutInitial extends HomeState {}

class HomeLoading extends HomeState {}

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

