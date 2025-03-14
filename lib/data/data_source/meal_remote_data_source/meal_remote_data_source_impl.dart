import 'package:injectable/injectable.dart' show Injectable;

import '../../../core/api/api_result.dart' show Result;
import '../../../core/api/execute_api_call.dart' show executeApiCall;
import '../../api/meal/meal_api_manager.dart' show MealApiManager;
import '../../models/meal/meal_model.dart' show Meal;
import 'meal_remote_data_source.dart' show MealRemoteDataSource;

@Injectable(as: MealRemoteDataSource)
class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final MealApiManager mealApiManager;

  MealRemoteDataSourceImpl({required this.mealApiManager});

  @override
  Future<Result<Meal?>> getMealDetails(String mealId) {
    return executeApiCall<Meal?>(() async {
      final response = await mealApiManager.getMealDetails(mealId);
      if (response.meals != null && response.meals!.isNotEmpty) {
        return response.meals!.first;
      }
      return null;
    });
  }
}