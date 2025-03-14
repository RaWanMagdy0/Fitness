import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../data/models/meal/meal_model.dart';
import '../../../domain/use_case/meal/meal_details_use_case.dart';

part 'meal_details_state.dart';

@injectable
class MealDetailsCubit extends BaseViewModel<MealDetailsState> {
  final MealDetailsUseCase _mealDetailsUseCase;

  MealDetailsCubit(this._mealDetailsUseCase) : super(MealDetailsInitial());

  Future<void> getMealDetails(String mealId) async {
    emit(MealDetailsLoading());
    final result = await _mealDetailsUseCase.invoke(mealId);

    switch (result) {
      case Success<Meal?>():
        if (result.data != null) {
          emit(MealDetailsSuccess(meal: result.data!));
        } else {
          emit(MealDetailsError(errorMessage: "No meal found"));
        }
      case Fail<Meal?>():
        emit(MealDetailsError(
          errorMessage: getErrorMassageFromException(result.exception),
        ));
    }
  }

  void selectDifficultyLevel(DifficultyLevel level) {
    if (state is MealDetailsSuccess) {
      final currentState = state as MealDetailsSuccess;
      emit(MealDetailsSuccess(
        meal: currentState.meal,
        selectedDifficulty: level,
      ));
    }
  }
}