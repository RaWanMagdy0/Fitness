import '../../../core/api/api_result.dart';
import '../../../data/models/workout/muscle_model.dart';

abstract class WorkoutRepository {
  Future<Result<List<MuscleGroup>?>> getMuscleGroups();
  Future<Result<MuscleDetailResponse?>> getMuscleGroupDetails(String muscleGroupId);
}