import '../../../core/api/api_result.dart';
import '../../models/meal/meals_response_model.dart';
import '../../models/meal/meals_tabs_response_model.dart';
import '../../models/meal/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<Result<Meal?>> getMealDetails(String mealId);
  Future<Result<List<Categories>>> fetchMealsTabs();
  Future<Result<List<Meals>>> fetchMealsByCategory(String category);
}
