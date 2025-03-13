
import '../../../core/api/api_result.dart';
import '../../entity/exercise/exercise_entity.dart';

abstract class HomeRepository{
  Future<Result<List<Exercise?>>>getUserData();

}