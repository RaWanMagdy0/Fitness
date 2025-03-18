import 'package:fitness_app/data/api/home_api/home_api_magager.dart';
import 'package:fitness_app/data/models/exercise/exercise_model.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/api/execute_api_call.dart';
import '../../../core/local/token_manger.dart';
import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiManager _homeApiManager;

  HomeRemoteDataSourceImpl( this._homeApiManager);

  @override
  Future<Result<List<ExerciseModel?>>> getExercise() {
    return executeApiCall<List<ExerciseModel?>>(() async {
      var token = await _getToken();
      final response = await _homeApiManager.getExercise(token);
      List<ExerciseModel?> exercises = response.exercises?.map((e) => e as ExerciseModel?).toList() ?? [];
      return exercises;
    });
  }
  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }


}
