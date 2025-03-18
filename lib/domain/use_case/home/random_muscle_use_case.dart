import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/home/random_muscle_entity.dart';
import '../../repository/home_repository/home_repository.dart';

@injectable
class RandomMuscleUseCase {
  final HomeRepository _homeRepository;
  RandomMuscleUseCase(this._homeRepository);
  Future<Result<List<MuscleEntity?>>> invoke() async {
    return await _homeRepository.getRandomMuscle();
  }
}
