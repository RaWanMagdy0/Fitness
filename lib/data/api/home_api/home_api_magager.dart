import 'package:dio/dio.dart';
import 'package:fitness_app/data/models/exercise/exercise_response_model.dart';
import 'package:fitness_app/data/models/level/get_all_level_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
import '../../models/exercise/get_exercise_by_muscle_and_level_response_model.dart';
import '../../models/exercise/get_level_by_muscle_id_response_model.dart';
import '../../models/home/muscle_group_by_id/muscle_group_by_id.dart';
import '../../models/home/random_muscle/get_random_muscles_response_model.dart';

part 'home_api_magager.g.dart';

@lazySingleton
@RestApi()
abstract class HomeApiManager {
  @factoryMethod
  factory HomeApiManager(Dio dio) = _HomeApiManager;

  @GET(ApiConstants.exercises)
  Future<ExerciseResponseModel> getExercise(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.randomMuscle)
  Future<GetRandomMusclesResponseModel> getRandomMuscle(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.muscleGroupById)
  Future<MuscleGroupById> getMuscleGroupById(
    @Header('Authorization') String token,
    @Query('muscleGroupId') String muscleGroupId,
  );

  @GET(ApiConstants.levels)
  Future<GetAllLevelResponseModel> getAllLevel(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.levelByMuscle)
  Future<GetLevelByMuscleIdResponseModel> getLevelsByMuscleId(
    @Header('Authorization') String token,
    @Query("primeMoverMuscleId") String primeMoverMuscleId,
  );

  @GET(ApiConstants.exerciseByMuscleAndDifficulty)
  Future<GetExerciseByMuscleAndLevelResponseModel> getExerciseByMuscleAndLevel(
    @Header('Authorization') String token,
    @Query("primeMoverMuscleId") String primeMoverMuscleId,
    @Query("difficultyLevelId") String difficultyLevelId,
  );
}
