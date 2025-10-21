import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/meal_remote_data_source/meal_remote_data_source.dart';
import 'package:fitness_app/data/models/meal/meal_model.dart';
import 'package:fitness_app/data/models/meal/meals_response_model.dart';
import 'package:fitness_app/data/models/meal/meals_tabs_response_model.dart';
import 'package:fitness_app/data/repository/meal_repository/meal_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_repo_impl_test.mocks.dart';

void registerMockitoDummies() {
  provideDummy<Result<Meal?>>(Success(data: null));
  provideDummy<Result<List<Categories>>>(Success(data: []));
  provideDummy<Result<List<Meals>>>(Success(data: []));
}

@GenerateMocks([MealRemoteDataSource])
void main() {
  late MealRepositoryImpl mealRepository;
  late MockMealRemoteDataSource mockMealRemoteDataSource;

  setUpAll(() {
    registerMockitoDummies();
  });

  setUp(() {
    mockMealRemoteDataSource = MockMealRemoteDataSource();
    mealRepository = MealRepositoryImpl(mockMealRemoteDataSource);
  });

  group('getMealDetails', () {
    const tMealId = '1';
    final tMeal = Meal(idMeal: '1', strMeal: 'Test Meal');
    final tException = Exception('Failed to get meal details');

    test(
        'should return a Meal when the call to the remote data source is successful',
        () async {
      when(mockMealRemoteDataSource.getMealDetails(tMealId))
          .thenAnswer((_) async => Success(data: tMeal));

      final result = await mealRepository.getMealDetails(tMealId);

      expect(result, isA<Success<Meal?>>());
      expect((result as Success).data, tMeal);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      when(mockMealRemoteDataSource.getMealDetails(tMealId))
          .thenAnswer((_) async => Fail(exception: tException));

      final result = await mealRepository.getMealDetails(tMealId);

      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('getMealsTabs', () {
    final tCategories = [Categories(idCategory: '1', strCategory: 'Test Tab')];
    final tException = Exception('Failed to get meals tabs');

    test(
        'should return a list of Categories when the call to the remote data source is successful',
        () async {
      when(mockMealRemoteDataSource.fetchMealsTabs())
          .thenAnswer((_) async => Success(data: tCategories));

      final result = await mealRepository.getMealsTabs();

      expect(result, isA<Success<List<Categories>>>());
      expect((result as Success).data, tCategories);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      when(mockMealRemoteDataSource.fetchMealsTabs())
          .thenAnswer((_) async => Fail(exception: tException));

      final result = await mealRepository.getMealsTabs();

      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });

  group('fetchMealsByCategory', () {
    const tCategory = 'Test';
    final tMeals = [Meals(idMeal: '1', strMeal: 'Test Meal')];
    final tException = Exception('Failed to fetch meals by category');

    test(
        'should return a list of Meals when the call to the remote data source is successful',
        () async {
      when(mockMealRemoteDataSource.fetchMealsByCategory(tCategory))
          .thenAnswer((_) async => Success(data: tMeals));

      final result = await mealRepository.fetchMealsByCategory(tCategory);

      expect(result, isA<Success<List<Meals>>>());
      expect((result as Success).data, tMeals);
    });

    test(
        'should return a Fail when the call to the remote data source is unsuccessful',
        () async {
      when(mockMealRemoteDataSource.fetchMealsByCategory(tCategory))
          .thenAnswer((_) async => Fail(exception: tException));

      final result = await mealRepository.fetchMealsByCategory(tCategory);

      expect(result, isA<Fail>());
      expect((result as Fail).exception, tException);
    });
  });
}
