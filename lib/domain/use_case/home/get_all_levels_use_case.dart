import 'package:fitness_app/domain/entity/level/level.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../repository/home_repository/home_repository.dart';

@injectable
class GetAllLevelsUseCase {
  final HomeRepository _homeRepository;
  GetAllLevelsUseCase(this._homeRepository);
  Future<Result<List<Level?>>> invoke() async {
    return await _homeRepository.getAllLevels();
  }
}
