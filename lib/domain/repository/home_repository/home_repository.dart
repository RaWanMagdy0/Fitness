import 'package:fitness_app/domain/entity/exercise/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entity/meal/exercise_by_muscle_and_level_entity.dart';

import '../../../core/api/api_result.dart';
import '../../entity/exercise/exercise_entity.dart';
import '../../entity/home/random_muscle_entity.dart';
import '../../entity/level/level.dart';

abstract class HomeRepository {
  Future<Result<List<Exercise?>>> getUserData();

  Future<Result<List<MuscleEntity?>>> getRandomMuscle();

  Future<Result<List<MuscleEntity?>>> getMuscleGroupById(String muscleGroupId);

  Future<Result<List<Level?>>> getAllLevels();

  Future<Result<List<DifficultyLevelEntity?>>> getLevelsByMuscleId(
      String primeMoverMuscleId);

  Future<Result<List<ExerciseByMuscleAndLevelEntity?>>>
      getExerciseByMuscleAndLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  );
}
