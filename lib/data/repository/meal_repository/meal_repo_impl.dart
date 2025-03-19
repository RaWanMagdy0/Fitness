import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart' show Result;
import '../../../domain/repository/meal_repository/meal_repo.dart';
import '../../data_source/meal_remote_data_source/meal_remote_data_source.dart';

import '../../models/meal/meals_response_model.dart';
import '../../models/meal/meals_tabs_response_model.dart';
import '../../models/meal/meal_model.dart';

@Injectable(as: MealRepository)
class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource _remoteDataSource;
  MealRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<Meal?>> getMealDetails(String mealId) async {
    return await _remoteDataSource.getMealDetails(mealId);
  }

  @override
  Future<Result<List<Categories>>> getMealsTabs() async {
    return _remoteDataSource.fetchMealsTabs();
  }

  @override
  Future<Result<List<Meals>>> fetchMealsByCategory(String category) async {
    return await _remoteDataSource.fetchMealsByCategory(category);
  }
}
