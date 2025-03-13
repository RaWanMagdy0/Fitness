import 'package:fitness_app/domain/use_case/home/exercise_use_case.dart';
import 'package:fitness_app/presentation/home/exercise_screen/view_model/exercise_state.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/entity/exercise/exercise_entity.dart';

@injectable
class ExerciseViewModel extends BaseViewModel<ExerciseState> {
  final ExerciseUseCase exerciseUseCase;

  ExerciseViewModel(
    this.exerciseUseCase,
  ) : super(ProfileInitialState());

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
}
