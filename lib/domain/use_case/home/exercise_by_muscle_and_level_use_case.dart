import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/meal/exercise_by_muscle_and_level_entity.dart';
import '../../repository/home_repository/home_repository.dart';

@injectable
class ExerciseByMuscleAndLevelUseCase {
  final HomeRepository _homeRepository;
  ExerciseByMuscleAndLevelUseCase(this._homeRepository);
  Future<Result<List<ExerciseByMuscleAndLevelEntity?>>> invoke(String primeMoverMuscleId,String difficultyLevelId) async {
    return await _homeRepository.getExerciseByMuscleAndLevel(primeMoverMuscleId, difficultyLevelId);
  }
}
