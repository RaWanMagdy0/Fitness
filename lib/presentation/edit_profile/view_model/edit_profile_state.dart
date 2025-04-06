part of 'edit_profile_cubit.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final String message;

  EditProfileSuccess(this.message);
}

class EditProfileError extends EditProfileState {
  final String errorMessage;

  EditProfileError(this.errorMessage);
}
class UploadPhotoLoadingState extends EditProfileState {}

class UploadPhotoSuccessState extends EditProfileState {
  final String? message;

  UploadPhotoSuccessState({this.message});
}

class UploadPhotoErrorState extends EditProfileState {
  final String? errorMessage;

  UploadPhotoErrorState({this.errorMessage});
}
