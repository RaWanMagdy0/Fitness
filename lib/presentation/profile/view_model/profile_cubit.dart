import 'dart:io';
import 'package:fitness_app/domain/use_case/profile/profile_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api/api_result.dart';
import '../../../../../../core/base/base_view_model.dart';
import '../../../domain/entity/profile/user.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit(
    this.profileUseCase,
  ) : super(ProfileInitialState());

  get uploadPhotoUseCase => null;

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    var result = await profileUseCase.invoke();
    switch (result) {
      case Success<User?>():
        var user = result.data;
        emit(GetUserDataSuccessState(user: user));
      case Fail<User?>():
        emit(GetUserDataErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> uploadPhoto(File photo) async {
    emit(UploadPhotoLoadingState());
    try {
      final result = await uploadPhotoUseCase.invoke(photo);
      if (result is Success<User?>) {
        emit(UploadPhotoSuccessState(user: result.data));
        // Refresh user data after successful upload
        getUserData();
      } else if (result is Fail<User?>) {
        emit(UploadPhotoErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
      }
    } catch (e) {
      emit(UploadPhotoErrorState(
          errorMessage: 'An unexpected error occurred: $e'));
    }
  }
}
