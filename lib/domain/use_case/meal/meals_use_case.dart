import 'package:fitness_app/data/models/meal/meals_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../repository/meal_repository/meal_repo.dart';

@injectable
class MealsUseCase {
  final MealRepository _repository;

  MealsUseCase(this._repository);

  Future<Result<List<Meals>>> invoke(String category) async {
    return await _repository.fetchMealsByCategory(category);
  }
}
