import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/meal/meal_model.dart';

part 'meal_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: "https://www.themealdb.com/api/json/v1/1/")
abstract class MealApiManager {
  @factoryMethod
  factory MealApiManager(Dio dio) = _MealApiManager;

  @GET("lookup.php")
  Future<MealResponse> getMealDetails(@Query("i") String mealId);
}