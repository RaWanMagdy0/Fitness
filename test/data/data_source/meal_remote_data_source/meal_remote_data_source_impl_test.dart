import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/api/meal/meal_api_manager.dart';
import 'package:fitness_app/data/datasources/meal/meal_remote_data_source.dart';
import 'package:fitness_app/data/models/meal/meals_response_model.dart';
import 'package:fitness_app/data/models/meal/meals_tabs_response_model.dart';
import 'package:fitness_app/data/models/meal/meal_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([MealApiManager])
void main() {
  late MealRemoteDataSourceImpl dataSource;
  late MockMealApiManager mockMealApiManager;

  setUp(() {
    mockMealApiManager = MockMealApiManager();
    dataSource = MealRemoteDataSourceImpl(mealApiManager: mockMealApiManager);
  });

  group('MealRemoteDataSourceImpl', () {
    const mealId = 'meal123';
    const category = 'Beef';

    test('getMealDetails returns Meal on success', () async {
      final mealResponse = MealsResponseModel(
        meals: [
          Meal(
              idMeal: 'meal123',
              strMeal: 'Spaghetti',
              strInstructions: 'Cook pasta'),
        ],
      );
      when(mockMealApiManager.getMealDetails(mealId))
          .thenAnswer((_) async => mealResponse);

      final result = await dataSource.getMealDetails(mealId);

      expect(result, isA<Success<Meal?>>());
      expect((result as Success<Meal?>).data, isNotNull);
      expect((result as Success<Meal?>).data!.idMeal, 'meal123');
      expect((result as Success<Meal?>).data!.strMeal, 'Spaghetti');
    });

    test('getMealDetails returns null when no meals found', () async {
      final mealResponse = MealsResponseModel(meals: []);
      when(mockMealApiManager.getMealDetails(mealId))
          .thenAnswer((_) async => mealResponse);

      final result = await dataSource.getMealDetails(mealId);

      expect(result, isA<Success<Meal?>>());
      expect((result as Success<Meal?>).data, isNull);
    });

    test('fetchMealsTabs returns list of Categories on success', () async {
      final tabsResponse = MealsTabsResponseModel(
        categories: [
          Categories(idCategory: '1', strCategory: 'Beef'),
          Categories(idCategory: '2', strCategory: 'Chicken'),
        ],
      );
      when(mockMealApiManager.fetchMealsTabs())
          .thenAnswer((_) async => tabsResponse);

      final result = await dataSource.fetchMealsTabs();

      expect(result, isA<Success<List<Categories>>>());
      expect((result as Success<List<Categories>>).data, isNotEmpty);
      expect((result as Success<List<Categories>>).data.length, 2);
      expect((result as Success<List<Categories>>).data[0].strCategory, 'Beef');
    });

    test('fetchMealsTabs returns empty list when no categories found',
        () async {
      final tabsResponse = MealsTabsResponseModel(categories: []);
      when(mockMealApiManager.fetchMealsTabs())
          .thenAnswer((_) async => tabsResponse);

      final result = await dataSource.fetchMealsTabs();

      expect(result, isA<Success<List<Categories>>>());
      expect((result as Success<List<Categories>>).data, isEmpty);
    });

    test('fetchMealsByCategory returns list of Meals on success', () async {
      final mealsResponse = MealsResponseModel(
        meals: [
          Meal(
              idMeal: 'meal123',
              strMeal: 'Beef Stew',
              strInstructions: 'Cook beef'),
          Meal(
              idMeal: 'meal124',
              strMeal: 'Beef Soup',
              strInstructions: 'Simmer beef'),
        ],
      );
      when(mockMealApiManager.getMealsByCategory(category))
          .thenAnswer((_) async => mealsResponse);

      final result = await dataSource.fetchMealsByCategory(category);

      expect(result, isA<Success<List<Meals>>>());
      expect((result as Success<List<Meals>>).data, isNotEmpty);
      expect((result as Success<List<Meals>>).data.length, 2);
      expect((result as Success<List<Meals>>).data[0].strMeal, 'Beef Stew');
    });

    test('fetchMealsByCategory returns empty list when no meals found',
        () async {
      final mealsResponse = MealsResponseModel(meals: []);
      when(mockMealApiManager.getMealsByCategory(category))
          .thenAnswer((_) async => mealsResponse);

      final result = await dataSource.fetchMealsByCategory(category);

      expect(result, isA<Success<List<Meals>>>());
      expect((result as Success<List<Meals>>).data, isEmpty);
    });
  });
}
