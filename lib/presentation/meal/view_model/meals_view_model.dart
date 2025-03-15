import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/domain/use_case/meal/meals_use_case.dart';
import 'package:fitness_app/domain/use_case/meal/meals_tabs_use_case.dart';

import 'package:injectable/injectable.dart';

import '../../../core/base/base_view_model.dart';
import '../../../data/models/meal/meals_response_model.dart';
import '../../../data/models/meal/meals_tabs_response_model.dart';
import 'meal_state.dart';

@injectable
class MealsViewModel extends BaseViewModel<MealsScreenState> {
  final MealsTabsUseCase _mealsTabsUseCase;
  final MealsUseCase _mealsUseCase;

  MealsViewModel(this._mealsTabsUseCase, this._mealsUseCase)
      : super(MealsScreenInitial());

  Future<void> fetchMealsTabs() async {
    emit(MealsTabsLoading());
    try {
      final result = await _mealsTabsUseCase.invoke();

      switch (result) {
        case Success<List<Categories>>():
          if (result.data != null && result.data!.isNotEmpty) {
            emit(MealsTabsSuccess(categories: result.data!));
          } else {
            emit(MealsTabsError(errorMessage: 'No Categories found'));
          }

        case Fail<List<Categories>>():
          emit(MealsTabsError(
              errorMessage: getErrorMassageFromException(result.exception)));
      }
    } catch (e) {
      print("Unexpected error in fetchCategories: $e");
      emit(MealsTabsError(errorMessage: 'Unexpected error: $e'));
    }
  }

  Future<void> fetchMealsByCategory(String category) async {
    emit(MealsLoading());

    try {
      final result = await _mealsUseCase.invoke(category);

      switch (result) {
        case Success<List<Meals>>():
          if (result.data != null && result.data!.isNotEmpty) {
            emit((MealsSuccess(meals: result.data!)));
          } else {
            emit(MealsTabsError(errorMessage: 'No Categories found'));
          }

        case Fail<List<Meals>>():
          emit(MealsTabsError(
              errorMessage: getErrorMassageFromException(result.exception)));
      }
    } catch (e) {
      print("Unexpected error in fetchCategories: $e");
      emit(MealsTabsError(errorMessage: 'Unexpected error: $e'));
    }
  }
}
