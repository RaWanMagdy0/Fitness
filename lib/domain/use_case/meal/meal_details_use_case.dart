import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../data/models/meal/meal_model.dart';
import '../../repository/meal_repository/meal_repository.dart';

@injectable
class MealDetailsUseCase {
  final MealRepository _mealRepository;

  MealDetailsUseCase(this._mealRepository);

  Future<Result<Meal?>> invoke(String mealId) async {
    return await _mealRepository.getMealDetails(mealId);
  }
}