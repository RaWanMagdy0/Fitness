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

//LogoutStates
class LogoutSuccessState extends ProfileState {
  String? message;

  LogoutSuccessState(this.message);
}

class LogoutErrorState extends ProfileState {
  String? message;

  LogoutErrorState(this.message);
}
