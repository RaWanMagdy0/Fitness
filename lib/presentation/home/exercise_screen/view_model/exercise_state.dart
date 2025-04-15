import 'package:fitness_app/domain/entity/level/level.dart';

import '../../../../domain/entity/exercise/difficulty_level_entity.dart';
import '../../../../domain/entity/exercise/exercise_entity.dart';
import '../../../../domain/entity/meal/exercise_by_muscle_and_level_entity.dart';

sealed class ExerciseState {}

final class ExerciseInitialState extends ExerciseState {}

class ExerciseLoadingState extends ExerciseState {}

class ExerciseSuccessState extends ExerciseState {
  final List<Exercise?> exercise;

  ExerciseSuccessState({required this.exercise});
}

class ExerciseErrorState extends ExerciseState {
  final String? errorMessage;

  ExerciseErrorState({this.errorMessage});
}

class LevelsLoadingState extends ExerciseState {}

class LevelsSuccessState extends ExerciseState {
  final List<Level?>? level;

  LevelsSuccessState({required this.level});
}

class LevelsErrorState extends ExerciseState {
  final String? errorMessage;

  LevelsErrorState({this.errorMessage});
}
class LevelsByMuscleLoadingState extends ExerciseState {}

class LevelsByMuscleSuccessState extends ExerciseState {
  final List<DifficultyLevelEntity?>? level;

  LevelsByMuscleSuccessState({required this.level});
}

class LevelsByMuscleErrorState extends ExerciseState {
  final String? errorMessage;

  LevelsByMuscleErrorState({this.errorMessage});
}

class ExerciseByMuscleLevelLoadingState extends ExerciseState {}

class ExerciseByMuscleLevelSuccessState extends ExerciseState {
  final List<ExerciseByMuscleAndLevelEntity?>? exercise;

  ExerciseByMuscleLevelSuccessState({required this.exercise});
}

class ExerciseByMuscleLevelErrorState extends ExerciseState {
  final String? errorMessage;

  ExerciseByMuscleLevelErrorState({this.errorMessage});
}

