import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/api/execute_api_call.dart';
import '../../api/workout/workout_api_manager.dart';
import '../../models/workout/muscle_model.dart';
import 'workout_remote_data_source.dart';

@Injectable(as: WorkoutRemoteDataSource)
class WorkoutRemoteDataSourceImpl implements WorkoutRemoteDataSource {
  final WorkoutApiManager workoutApiManager;

  WorkoutRemoteDataSourceImpl({required this.workoutApiManager});

  @override
  Future<Result<List<MuscleGroup>?>> getMuscleGroups() {
    return executeApiCall<List<MuscleGroup>?>(() async {
      final response = await workoutApiManager.getMuscleGroups();
      return response.musclesGroup;
    });
  }

  @override
  Future<Result<MuscleDetailResponse?>> getMuscleGroupDetails(String muscleGroupId) {
    return executeApiCall<MuscleDetailResponse?>(() async {
      final response = await workoutApiManager.getMuscleGroupDetails(muscleGroupId);
      return response;
    });
  }
}