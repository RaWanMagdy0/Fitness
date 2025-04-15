import 'dart:io';

import 'package:injectable/injectable.dart';
import '../../../../domain/use_case/auth/edit_profile_use_case.dart';
import '../../../core/api/api_result.dart';
import '../../../core/base/base_view_model.dart';
import '../../../core/local/token_manger.dart';
import '../../../data/models/edit_profile/edit_profile_request_model.dart';
import '../../../data/models/edit_profile/edit_profile_response_model.dart';
import '../../../domain/use_case/profile/upload_photo_use_case.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileCubit extends BaseViewModel<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase uploadPhotoUseCase;

  EditProfileCubit(this._editProfileUseCase, this.uploadPhotoUseCase) : super(EditProfileInitial());

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
    if (result is Success<String?>) {
      emit(EditProfileSuccess(result.data ));
    } else if (result is Fail<String?>) {
      emit(EditProfileError(
          errorMessage: getErrorMassageFromException(result.exception)));

    }
  }
  Future<void> uploadPhoto(File photo) async {
    emit(UploadPhotoLoadingState());
    var result = await uploadPhotoUseCase.invoke(photo);
    if (result is Success<String?>) {
      emit(UploadPhotoSuccessState(message: result.data));
    } else if (result is Fail<String?>) {
      emit(UploadPhotoErrorState(
          errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
}