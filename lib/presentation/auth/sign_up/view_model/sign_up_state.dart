part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final String? message;

  SignUpSuccess(this.message);
}

final class SignUpFail extends SignUpState {
  final String? errorMassage;

  SignUpFail(this.errorMassage);
}
