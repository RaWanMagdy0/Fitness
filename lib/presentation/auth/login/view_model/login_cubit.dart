import 'package:fitness_app/presentation/auth/login/view_model/login_state.dart' show LoginError, LoginInitial, LoginLoading, LoginState, LoginSuccess;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart' show Fail, Success;
import '../../../../data/models/login/request/login_request_model.dart' show LoginRequestModel;
import '../../../../domain/repository/auth_repository/auth_repository.dart' show AuthRepository;


@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    final loginRequest = LoginRequestModel(
      email: email,
      password: password,
    );

    final result = await _authRepository.login(loginRequest);

    if (result is Success) {
      final successResult = result as Success;
      emit(LoginSuccess(successResult.data ?? "Login successful"));
    } else if (result is Fail) {
      final failResult = result as Fail;
      emit(LoginError(failResult.exception?.toString() ?? "Login failed"));
    }
  }
}