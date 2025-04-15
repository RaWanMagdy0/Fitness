import 'package:fitness_app/data/models/exercise/exercise_model.dart';
import '../../../core/api/api_result.dart';
import '../../models/exercise/difficulty_level_model.dart';
import '../../models/exercise/exercise_by_muscle_and_level_model.dart';
import '../../models/home/random_muscle/muscle_model.dart';
import '../../models/level/level_model.dart';

abstract class HomeRemoteDataSource{
  Future<Result<List<ExerciseModel?>>> getExercise();
  Future<Result<List<MuscleModel?>>> getRandomMuscle();
  Future<Result<List<MuscleModel?>>> getMuscleGroupById(String muscleGroupId);
  Future<Result<List<LevelModel?>>> getAllLevels();
  Future<Result<List<DifficultyLevelModel?>>> getLevelsByMuscleId(String primeMoverMuscleId);
  Future<Result<List<ExerciseByMuscleAndLevelModel >>> getExerciseByMuscleAndLevel(String primeMoverMuscleId , String difficultyLevelId,);

}

