import 'package:fitness_app/domain/repository/meal_repository/meal_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../data/models/meal/meals_tabs_response_model.dart';
import '../../entity/meal/meals_tabs_entity.dart';

@injectable
class MealsTabsUseCase {
  final MealRepository _repository;

  MealsTabsUseCase(this._repository);

  Future<Result<List<Categories>>> invoke() async {
    return await _repository.getMealsTabs();
  }
}
