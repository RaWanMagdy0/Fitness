import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../data/models/meal/meals_tabs_response_model.dart';
import '../../../../domain/entity/home/random_muscle_entity.dart';
import '../../../../domain/use_case/home/exercise_use_case.dart';
import '../../../../domain/use_case/home/muscle_group_by_id.dart';
import '../../../../domain/use_case/home/random_muscle_use_case.dart';
import '../../../../domain/use_case/meal/meals_tabs_use_case.dart';
import '../../../../domain/use_case/workout/get_muscle_groups_use_case.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends BaseViewModel<HomeState> {
  final GetMuscleGroupsUseCase _getMuscleGroupsUseCase;
  final MealsTabsUseCase _mealsTabsUseCase;
  final RandomMuscleUseCase randomMuscleUseCase;
  final MuscleGroupByIdUseCase muscleGroupByIdUseCase;
  final ExerciseUseCase exerciseUseCase;

  bool _isLoadingSequence = false;

  HomeCubit(
      this._getMuscleGroupsUseCase,
      this._mealsTabsUseCase,
      this.randomMuscleUseCase,
      this.muscleGroupByIdUseCase, this.exerciseUseCase,
      ) : super(WorkoutInitial());

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

  Future<void> getRandomMuscle() async {
    emit(RandomMuscleLoading());

    var result = await randomMuscleUseCase.invoke();

    switch (result) {
      case Success<List<MuscleEntity?>>():
        emit(RandomMuscleSuccess(muscleEntity: result.data));

      case Fail<List<MuscleEntity?>>():
        emit(RandomMuscleError(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> getMuscleGroups() async {
    emit(GetMuscleLoading());
    try {
      final result = await _getMuscleGroupsUseCase.invoke();

      print("🔍 API Response: $result");

      switch (result) {
        case Success():
          print("✅ Success - Data: ${result.data}");
          if (result.data != null && result.data!.isNotEmpty) {
            emit(GetMuscleSuccess(muscleGroups: result.data!));
          } else {
            print("⚠️ No data found!");
            emit(GetMuscleError(errorMessage: "No muscle groups found"));
          }
          break;

        case Fail():
          print("❌ API Error: ${result.exception}");
          emit(GetMuscleError(
            errorMessage: getErrorMassageFromException(result.exception),
          ));
          break;
      }
    } catch (e, stacktrace) {
      print("🚨 Unexpected Error: $e\n$stacktrace");
      emit(GetMuscleError(errorMessage: "Unexpected error: $e"));
    }
  }

  Future<void> getMuscleGroupById(String muscleGroupId) async {
    emit(MuscleGroupIdLoading());

    try {
      var result = await muscleGroupByIdUseCase.invoke(muscleGroupId);
      print("Result received: $result");

      switch (result) {
        case Success<List<MuscleEntity?>>():
          print("Success with data: ${result.data}");
          emit(MuscleGroupIdSuccess(muscleEntity: result.data));
          break;
        case Fail<List<MuscleEntity?>>():
          print("Failed: ${result.exception}");
          emit(MuscleGroupIdError(
              errorMessage: getErrorMassageFromException(result.exception)));
      }
    } catch (e) {
      print("Exception: $e");
      emit(MuscleGroupIdError(errorMessage: "Unexpected error: ${e.toString()}"));
    }
  }

  Future<void> getExercise({String? difficultyLevel}) async {
    emit(HomeExerciseLoadingState());

    var result = await exerciseUseCase.invoke();

    switch (result) {
      case Success():

        emit(HomeExerciseSuccessState(exercise: result.data));

      case Fail():
        emit(HomeExerciseErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }



}
