
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/workout/muscle_model.dart';

part 'workout_api_manager.g.dart';

@lazySingleton
@RestApi()
abstract class WorkoutApiManager {
  @factoryMethod
  factory WorkoutApiManager(Dio dio) = _WorkoutApiManager;

  @GET('api/v1/muscles')
  Future<MuscleGroupResponse> getMuscleGroups();

  @GET('api/v1/musclesGroup/{id}')
  Future<MuscleDetailResponse> getMuscleGroupDetails(@Path('id') String muscleGroupId);
}