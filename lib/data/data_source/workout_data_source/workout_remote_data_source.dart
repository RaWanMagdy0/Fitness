import '../../../core/api/api_result.dart';
import '../../models/workout/muscle_model.dart';

abstract class WorkoutRemoteDataSource {
  Future<Result<List<MuscleGroup>?>> getMuscleGroups();
  Future<Result<MuscleDetailResponse?>> getMuscleGroupDetails(String muscleGroupId);
}