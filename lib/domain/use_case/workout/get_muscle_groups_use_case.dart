import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart' show Result;
import '../../../data/models/workout/muscle_model.dart' show MuscleGroup;
import '../../repository/workout_repository/workout_repository.dart' show WorkoutRepository;


@injectable
class GetMuscleGroupsUseCase {
  final WorkoutRepository _workoutRepository;

  GetMuscleGroupsUseCase(this._workoutRepository);

  Future<Result<List<MuscleGroup>?>> invoke() async {
    return await _workoutRepository.getMuscleGroups();
  }
}