part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}
class ForgotPasswordSuccess extends ForgotPasswordState {

}
class ForgotPasswordError extends ForgotPasswordState {
  final String errorMessage;
  ForgotPasswordError(this.errorMessage);

}

class ResetPasswordLoading extends ForgotPasswordState {}
class ResetPasswordSuccess extends ForgotPasswordState {
}
class ResetPasswordError extends ForgotPasswordState {
  final String errorMessage;
  ResetPasswordError(this.errorMessage);

}

class VerifyCodePasswordLoading extends ForgotPasswordState {}
class VerifyCodePasswordSuccess extends ForgotPasswordState {

}
class VerifyCodePasswordError extends ForgotPasswordState {
  final String errorMessage;
  VerifyCodePasswordError(this.errorMessage);

}


class ResendTimerStarted extends ForgotPasswordState {
  final int secondsRemaining;
  ResendTimerStarted(this.secondsRemaining);
}

class ResendTimerComplete extends ForgotPasswordState {}

class OtpExpired extends ForgotPasswordState {}