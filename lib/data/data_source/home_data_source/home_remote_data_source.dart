import 'package:fitness_app/data/models/exercise/exercise_model.dart';
import '../../../core/api/api_result.dart';

abstract class HomeRemoteDataSource{
  Future<Result<List<ExerciseModel?>>> getExercise();

}