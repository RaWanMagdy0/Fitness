import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../domain/repository/workout_repository/workout_repository.dart';
import '../../data_source/workout_data_source/workout_remote_data_source.dart';
import '../../models/workout/muscle_model.dart';

@Injectable(as: WorkoutRepository)
class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDataSource workoutRemoteDataSource;

  WorkoutRepositoryImpl({required this.workoutRemoteDataSource});

  @override
  Future<Result<List<MuscleGroup>?>> getMuscleGroups() async {
    return await workoutRemoteDataSource.getMuscleGroups();
  }

  @override
  Future<Result<MuscleDetailResponse?>> getMuscleGroupDetails(String muscleGroupId) async {
    return await workoutRemoteDataSource.getMuscleGroupDetails(muscleGroupId);
  }
}