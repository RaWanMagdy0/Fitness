
import '../../../core/api/api_result.dart';
import '../../entity/exercise/exercise_entity.dart';
import '../../entity/home/random_muscle_entity.dart';

abstract class HomeRepository{
  Future<Result<List<Exercise?>>>getUserData();
  Future<Result<List<MuscleEntity?>>>getRandomMuscle();
  Future<Result<List<MuscleEntity?>>>getMuscleGroupById(String muscleGroupId);

}