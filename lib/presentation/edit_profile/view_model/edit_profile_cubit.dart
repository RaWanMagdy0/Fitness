import 'package:injectable/injectable.dart';
import '../../../../domain/use_case/auth/edit_profile_use_case.dart';
import '../../../core/api/api_result.dart' show Fail, Success;
import '../../../core/base/base_view_model.dart' show BaseViewModel;
import '../../../data/models/edit_profile/edit_profile_request_model.dart' show EditProfileRequestModel;
import '../../../data/models/edit_profile/edit_profile_response_model.dart' show EditProfileResponseModel;

part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends BaseViewModel<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;

  EditProfileCubit(this._editProfileUseCase) : super(EditProfileInitial());

  Future<void> editProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? gender,
    int? height,
    int? weight,
    int? age,
    String? goal,
    String? activityLevel,
  }) async {
    emit(EditProfileLoading());

    final requestModel = EditProfileRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      height: height,
      weight: weight,
      age: age,
      goal: goal,
      activityLevel: activityLevel,
    );

    final result = await _editProfileUseCase.invoke(requestModel);

    if (result is Success<EditProfileResponseModel>) {
      final data = (result).data;
      emit(EditProfileSuccess(data?.message ?? "Profile updated successfully"));
    } else if (result is Fail<EditProfileResponseModel>) {
      final exception = (result).exception;
      emit(EditProfileError(getErrorMassageFromException(exception)));
    }
  }
}