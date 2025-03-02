part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordEmailSent extends ForgotPasswordState {}

class ForgotPasswordCodeVerified extends ForgotPasswordState {}

class ForgotPasswordComplete extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
}

class ResendTimerStarted extends ForgotPasswordState {
  final int secondsRemaining;
  ResendTimerStarted(this.secondsRemaining);
}

class ResendTimerComplete extends ForgotPasswordState {}

class OtpExpired extends ForgotPasswordState {}