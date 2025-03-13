import '../../../../domain/entity/exercise/exercise_entity.dart';

sealed class ExerciseState {}

final class ProfileInitialState extends ExerciseState {}

class ExerciseLoadingState extends ExerciseState {}

class ExerciseSuccessState extends ExerciseState {
  final List<Exercise?> exercise;

  ExerciseSuccessState({required this.exercise});
}

class ExerciseErrorState extends ExerciseState {
  final String? errorMessage;

  ExerciseErrorState({this.errorMessage});
}

