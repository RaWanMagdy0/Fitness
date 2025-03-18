import '../../../../data/models/workout/muscle_model.dart';

abstract class WorkoutState {}

// States for muscle groups
class WorkoutInitial extends WorkoutState {}

class GetMuscleGroupsLoading extends WorkoutState {}

class GetMuscleGroupsSuccess extends WorkoutState {
  final List<MuscleGroup> muscleGroups;

  GetMuscleGroupsSuccess({required this.muscleGroups});
}

class GetMuscleGroupsError extends WorkoutState {
  final String? errorMessage;

  GetMuscleGroupsError({this.errorMessage});
}

// States for muscle group details
class GetMuscleDetailsLoading extends WorkoutState {}

class GetMuscleDetailsSuccess extends WorkoutState {
  final MuscleDetailResponse response;

  GetMuscleDetailsSuccess({
    required this.response,
  });
}

class GetMuscleDetailsError extends WorkoutState {
  final String? errorMessage;

  GetMuscleDetailsError({this.errorMessage});
}