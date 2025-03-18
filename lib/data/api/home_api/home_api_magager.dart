import 'package:dio/dio.dart';
import 'package:fitness_app/data/models/exercise/exercise_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
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
}
