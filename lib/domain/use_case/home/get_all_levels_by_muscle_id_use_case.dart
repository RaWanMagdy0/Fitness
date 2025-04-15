import 'package:fitness_app/domain/entity/exercise/difficulty_level_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../repository/home_repository/home_repository.dart';

@injectable
class GetAllLevelsByMuscleIdUseCase {
  final HomeRepository _homeRepository;
  GetAllLevelsByMuscleIdUseCase(this._homeRepository);
  Future<Result<List<DifficultyLevelEntity?>>> invoke(String primeMoverMuscleId) async {
    return await _homeRepository.getLevelsByMuscleId(primeMoverMuscleId);
  }
}
