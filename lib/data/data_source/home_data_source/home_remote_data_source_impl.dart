import 'package:fitness_app/data/api/home_api/home_api_magager.dart';
import 'package:fitness_app/data/models/exercise/difficulty_level_model.dart';
import 'package:fitness_app/data/models/exercise/exercise_by_muscle_and_level_model.dart';
import 'package:fitness_app/data/models/exercise/exercise_model.dart';
import 'package:fitness_app/data/models/level/level_model.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/api/execute_api_call.dart';
import '../../../core/local/token_manger.dart';
import '../../models/home/random_muscle/muscle_model.dart';
import 'home_remote_data_source.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiManager _homeApiManager;

  HomeRemoteDataSourceImpl(this._homeApiManager);

  @override
  Future<Result<List<ExerciseModel?>>> getExercise() {
    return executeApiCall<List<ExerciseModel?>>(() async {
      var token = await _getToken();
      final response = await _homeApiManager.getExercise(token);
      List<ExerciseModel?> exercises =
          response.exercises?.map((e) => e as ExerciseModel?).toList() ?? [];
      return exercises;
    });
  }

  @override
  Future<Result<List<MuscleModel?>>> getRandomMuscle() {
    return executeApiCall<List<MuscleModel?>>(() async {
      var token = await _getToken();
      final response = await _homeApiManager.getRandomMuscle(token);
      List<MuscleModel?> randomMuscle =
          response.muscles?.map((e) => e as MuscleModel?).toList() ?? [];
      return randomMuscle;
    });
  }

  @override
  Future<Result<List<MuscleModel?>>> getMuscleGroupById(String muscleGroupId) {
    return executeApiCall<List<MuscleModel?>>(() async {
      var token = await _getToken();
      final response =
          await _homeApiManager.getMuscleGroupById(token, muscleGroupId);
      List<MuscleModel?> getMuscleGroupById =
          response.muscles?.map((e) => e as MuscleModel?).toList() ?? [];
      return getMuscleGroupById;
    });
  }

  @override
  Future<Result<List<LevelModel?>>> getAllLevels() {
    return executeApiCall<List<LevelModel?>>(() async {
      var token = await _getToken();
      final response = await _homeApiManager.getAllLevel(token);
      List<LevelModel?> levels =
          response.levels?.map((e) => e as LevelModel?).toList() ?? [];
      return levels;
    });
  }

  @override
  Future<Result<List<DifficultyLevelModel>>> getLevelsByMuscleId(
      String primeMoverMuscleId) {
    return executeApiCall<List<DifficultyLevelModel>>(() async {
      var token = await _getToken();
      final response =
          await _homeApiManager.getLevelsByMuscleId(token, primeMoverMuscleId);
      List<DifficultyLevelModel> difficultyLevels =
          response.difficultyLevels ?? [];
      return difficultyLevels;
    });
  }

  @override
  Future<Result<List<ExerciseByMuscleAndLevelModel>>>
      getExerciseByMuscleAndLevel(
          String primeMoverMuscleId, String difficultyLevelId) {
    return executeApiCall<List<ExerciseByMuscleAndLevelModel>>(() async {
      var token = await _getToken();
      final response = await _homeApiManager.getExerciseByMuscleAndLevel(
          token, primeMoverMuscleId, difficultyLevelId);
      List<ExerciseByMuscleAndLevelModel> exercise = response.exercises ?? [];
      return exercise;
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
