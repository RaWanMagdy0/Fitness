import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../entity/exercise/exercise_entity.dart';
import '../../repository/home_repository/home_repository.dart';

@injectable
class ExerciseUseCase {
  final HomeRepository _homeRepository;
  ExerciseUseCase(this._homeRepository);
  Future<Result<List<Exercise?>>> invoke() async {
    return await _homeRepository.getUserData();
  }
}
