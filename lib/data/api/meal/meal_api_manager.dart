import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
import '../../models/meal/meals_response_model.dart';
import '../../models/meal/meals_tabs_response_model.dart';
import '../../models/meal/meal_model.dart';

part 'meal_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseFood)
abstract class MealApiManager {
  @factoryMethod
  factory MealApiManager(Dio dio) = _MealApiManager;

  @GET("lookup.php")
  Future<MealResponse> getMealDetails(@Query("i") String mealId);

  @GET("categories.php")
  Future<MealsTabsResponseModel> fetchMealsTabs();

  @GET("filter.php")
  Future<MealsResponseModel> getMealsByCategory(@Query("c") String category);
}
