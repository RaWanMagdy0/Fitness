
import 'package:injectable/injectable.dart';

import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../domain/use_case/workout/get_muscle_group_details_use_case.dart' show GetMuscleGroupDetailsUseCase;
import '../../../domain/use_case/workout/get_muscle_groups_use_case.dart' show GetMuscleGroupsUseCase;
import 'workout_state.dart';

@injectable
class WorkoutCubit extends BaseViewModel<WorkoutState> {
  final GetMuscleGroupsUseCase _getMuscleGroupsUseCase;
  final GetMuscleGroupDetailsUseCase _getMuscleGroupDetailsUseCase;

  String? selectedMuscleGroupId;

  WorkoutCubit(
      this._getMuscleGroupsUseCase,
      this._getMuscleGroupDetailsUseCase,
      ) : super(WorkoutInitial());

  Future<void> getMuscleGroups() async {
    emit(GetMuscleGroupsLoading());

    final result = await _getMuscleGroupsUseCase.invoke();

    switch (result) {
      case Success():
        if (result.data != null && result.data!.isNotEmpty) {
          emit(GetMuscleGroupsSuccess(muscleGroups: result.data!));
        } else {
          emit(GetMuscleGroupsError(errorMessage: "No muscle groups found"));
        }
      case Fail():
        emit(GetMuscleGroupsError(
          errorMessage: getErrorMassageFromException(result.exception),
        ));
    }
  }

  Future<void> getMuscleGroupDetails(String muscleGroupId) async {
    emit(GetMuscleDetailsLoading());
    selectedMuscleGroupId = muscleGroupId;

    final result = await _getMuscleGroupDetailsUseCase.invoke(muscleGroupId);

    switch (result) {
      case Success():
        if (result.data != null) {
          emit(GetMuscleDetailsSuccess(
            response: result.data!,
            selectedGroupId: muscleGroupId,
          ));
        } else {
          emit(GetMuscleDetailsError(errorMessage: "No details found"));
        }
      case Fail():
        emit(GetMuscleDetailsError(
          errorMessage: getErrorMassageFromException(result.exception),
        ));
    }
  }
}