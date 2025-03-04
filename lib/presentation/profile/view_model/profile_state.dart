
import '../../../domain/entity/profile/user.dart';

sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

//GetLoggedUserInfo
class GetUserDataLoadingState extends ProfileState {}

class GetUserDataSuccessState extends ProfileState {
  final User? user;

  GetUserDataSuccessState({this.user});
}

class GetUserDataErrorState extends ProfileState {
  final String? errorMessage;

  GetUserDataErrorState({this.errorMessage});
}

class UploadPhotoLoadingState extends ProfileState {}

class UploadPhotoSuccessState extends ProfileState {
  final User? user;

  UploadPhotoSuccessState({this.user});
}

class UploadPhotoErrorState extends ProfileState {
  final String? errorMessage;

  UploadPhotoErrorState({this.errorMessage});
}

