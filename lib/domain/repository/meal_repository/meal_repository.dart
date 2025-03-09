import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../data/data_source/meal_remote_data_source/meal_remote_data_source.dart' show MealRemoteDataSource;
import '../../../data/models/meal/meal_model.dart' show Meal;
import '../../../data/repository/meal_repository/meal_repository_impl.dart' show MealRepository;

@Injectable(as: MealRepository)
class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource mealRemoteDataSource;

  MealRepositoryImpl({required this.mealRemoteDataSource});

  @override
  Future<Result<Meal?>> getMealDetails(String mealId) async {
    return await mealRemoteDataSource.getMealDetails(mealId);
  }
}