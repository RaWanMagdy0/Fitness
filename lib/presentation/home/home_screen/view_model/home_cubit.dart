import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../domain/use_case/workout/get_muscle_group_details_use_case.dart';
import '../../../../domain/use_case/workout/get_muscle_groups_use_case.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends BaseViewModel<HomeState> {
  final GetMuscleGroupsUseCase _getMuscleGroupsUseCase;
  final GetMuscleGroupDetailsUseCase _getMuscleGroupDetailsUseCase;

  String? selectedMuscleGroupId;

  HomeCubit(
    this._getMuscleGroupsUseCase,
    this._getMuscleGroupDetailsUseCase,
  ) : super(WorkoutInitial());

  Future<void> getMuscleGroups() async {
    emit(HomeLoading());

    final result = await _getMuscleGroupsUseCase.invoke();

    switch (result) {
      case Success():
        if (result.data != null && result.data!.isNotEmpty) {
          emit(GetMuscleSuccess(muscleGroups: result.data!));
        } else {
          emit(GetMuscleError(errorMessage: "No muscle groups found"));
        }
      case Fail():
        emit(GetMuscleError(
          errorMessage: getErrorMassageFromException(result.exception),
        ));
    }
  }

}
