import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/workout/muscle_model.dart';
import '../../repository/workout_repository/workout_repository.dart';

@injectable
class GetMuscleGroupDetailsUseCase {
  final WorkoutRepository _workoutRepository;

  GetMuscleGroupDetailsUseCase(this._workoutRepository);

  Future<Result<MuscleDetailResponse?>> invoke(String muscleGroupId) async {
    return await _workoutRepository.getMuscleGroupDetails(muscleGroupId);
  }
}