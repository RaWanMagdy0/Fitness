import '../../../core/api/api_result.dart';
import '../../models/meal/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<Result<Meal?>> getMealDetails(String mealId);
}

