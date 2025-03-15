import '../../../core/api/api_result.dart';
import '../../../data/models/meal/meals_response_model.dart';
import '../../../data/models/meal/meals_tabs_response_model.dart';
import '../../../data/models/meal/meal_model.dart';
import '../../entity/meal/meals_tabs_entity.dart';

abstract class MealRepository {
  Future<Result<Meal?>> getMealDetails(String mealId);
  Future<Result<List<Categories>>> getMealsTabs();
  Future<Result<List<Meals>>> fetchMealsByCategory(String category);
}
