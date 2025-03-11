import '../../../core/api/api_result.dart';
import '../../../data/models/meal/meal_model.dart';

abstract class MealRepository {
  Future<Result<Meal?>> getMealDetails(String mealId);
}