import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart' show Fail, Success;
import '../../../../data/models/forgot_password/request/forgot_password_request_model.dart' show ForgotPasswordRequestModel;
import '../../../../data/models/forgot_password/request/reset_password_request_model.dart' show ResetPasswordRequestModel;
import '../../../../data/models/forgot_password/request/verify_code_request_model.dart' show VerifyCodeRequestModel;
import '../../../../domain/repository/auth_repository/auth_repository.dart';

part 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;
  Timer? _resendTimer;
  Timer? _otpExpiryTimer;
  String? _email;

  ForgotPasswordCubit({required this.authRepository}) : super(ForgotPasswordInitial());

  void setEmail(String email) {
    _email = email;
  }

  String? get email => _email;

  Future<void> sendForgotPasswordEmail(String email) async {
    emit(ForgotPasswordLoading());
    setEmail(email);

    final result = await authRepository.forgotPassword(
      ForgotPasswordRequestModel(email: email),
    );

    if (result is Success) {
      final _ = result as Success;
      startResendTimer();
      startOtpExpiryTimer();
      emit(ForgotPasswordEmailSent());
    } else if (result is Fail) {
      final failResult = result as Fail;
      emit(ForgotPasswordError(failResult.exception?.toString() ?? "Error sending email"));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(ForgotPasswordLoading());

    final result = await authRepository.verifyResetCode(
      VerifyCodeRequestModel(resetCode: code),
    );

    if (result is Success) {
      final _ = result as Success;
      emit(ForgotPasswordCodeVerified());
    } else if (result is Fail) {
      final failResult = result as Fail;
      emit(ForgotPasswordError(failResult.exception?.toString() ?? "Invalid code"));
    }
  }

  Future<void> resetPassword(String password) async {
    if (_email == null) {
      emit(ForgotPasswordError("Email not found"));
      return;
    }

    emit(ForgotPasswordLoading());

    final result = await authRepository.resetPassword(
      ResetPasswordRequestModel(
        email: _email!,
        newPassword: password,
      ),
    );

    if (result is Success) {
      final _ = result as Success;
      emit(ForgotPasswordComplete());
    } else if (result is Fail) {
      final failResult = result as Fail;
      emit(ForgotPasswordError(failResult.exception?.toString() ?? "Error resetting password"));
    }
  }

  void startResendTimer() {
    _resendTimer?.cancel();
    emit(ResendTimerStarted(30));

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentState = state;
      if (currentState is ResendTimerStarted) {
        if (currentState.secondsRemaining > 0) {
          emit(ResendTimerStarted(currentState.secondsRemaining - 1));
        } else {
          timer.cancel();
          emit(ResendTimerComplete());
        }
      }
    });
  }

  void startOtpExpiryTimer() {
    _otpExpiryTimer?.cancel();
    _otpExpiryTimer = Timer(const Duration(minutes: 10), () {
      emit(OtpExpired());
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    _otpExpiryTimer?.cancel();
    return super.close();
  }
}
