import 'package:fitness_app/domain/entity/exercise/difficulty_level_entity.dart';
import 'package:fitness_app/domain/entity/level/level.dart';
import 'package:fitness_app/domain/use_case/home/exercise_use_case.dart';
import 'package:fitness_app/domain/use_case/home/get_all_levels_by_muscle_id_use_case.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view_model/exercise_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/entity/exercise/exercise_entity.dart';
import '../../../../domain/entity/meal/exercise_by_muscle_and_level_entity.dart';
import '../../../../domain/use_case/home/exercise_by_muscle_and_level_use_case.dart';
import '../../../../domain/use_case/home/get_all_levels_use_case.dart';


@injectable
class ExerciseViewModel extends BaseViewModel<ExerciseState> {
  final ExerciseUseCase exerciseUseCase;
  final GetAllLevelsUseCase getAllLevelsUseCase;
  final GetAllLevelsByMuscleIdUseCase getAllLevelsByMuscleIdUseCase;
  final ExerciseByMuscleAndLevelUseCase exerciseByMuscleAndLevelUseCase;

  ExerciseViewModel(this.exerciseUseCase, this.getAllLevelsUseCase, this.getAllLevelsByMuscleIdUseCase, this.exerciseByMuscleAndLevelUseCase,)
      : super(ExerciseInitialState());

  Future<void> getExercise({String? difficultyLevel}) async {
    emit(ExerciseLoadingState());

    var result = await exerciseUseCase.invoke();

    switch (result) {
      case Success<List<Exercise?>>():
        List<Exercise?> filteredExercises = result.data
            ?.where((exercise) =>
        difficultyLevel == null ||
            exercise?.difficultyLevel == difficultyLevel)
            .toList() ??
            [];

        emit(ExerciseSuccessState(exercise: filteredExercises));

      case Fail<List<Exercise?>>():
        emit(ExerciseErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
  Future<void> getAllLevels() async {
    emit(ExerciseLoadingState());
    var result = await getAllLevelsUseCase.invoke();
    switch (result) {
      case Success<List<Level?>>():
        emit(LevelsSuccessState(level: result.data));
        break;
      case Fail<List<Level?>>():
        emit(LevelsErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
  Future<void> getAllLevelsBuMuscleId(String primeMoverMuscleId) async {
    emit(LevelsByMuscleLoadingState());
    var result = await getAllLevelsByMuscleIdUseCase.invoke(primeMoverMuscleId);
    switch (result) {
      case Success<List<DifficultyLevelEntity?>>():
        emit(LevelsByMuscleSuccessState(level: result.data));
        break;
      case Fail<List<DifficultyLevelEntity?>>():
        emit(LevelsByMuscleErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> getExerciseByMuscleAndLevel(String primeMoverMuscleId, String difficultyLevelId) async {
    emit(ExerciseByMuscleLevelLoadingState());
    var result = await exerciseByMuscleAndLevelUseCase.invoke(primeMoverMuscleId, difficultyLevelId);
    switch (result) {
      case Success<List<ExerciseByMuscleAndLevelEntity?>>():
        emit(ExerciseByMuscleLevelSuccessState(exercise: result.data));
        break;
      case Fail<List<ExerciseByMuscleAndLevelEntity?>>():
        emit(ExerciseByMuscleLevelErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }



}