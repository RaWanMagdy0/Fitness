import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/home/random_muscle_entity.dart';
import '../../repository/home_repository/home_repository.dart';

@injectable
class MuscleGroupByIdUseCase {
  final HomeRepository _homeRepository;
  MuscleGroupByIdUseCase(this._homeRepository);
  Future<Result<List<MuscleEntity?>>> invoke(String muscleGroupId) async {
    return await _homeRepository.getMuscleGroupById(muscleGroupId);
  }
}
