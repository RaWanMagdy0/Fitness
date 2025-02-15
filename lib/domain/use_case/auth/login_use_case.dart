import '../../../core/api/api_result.dart' show Result;
import '../../../data/models/login/request/login_request_model.dart' show LoginRequestModel;
import '../../repository/auth_repository/auth_repository.dart' show AuthRepository;

class LoginUseCase {
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);

  Future<Result<String?>> invoke(LoginRequestModel loginRequestBody) async {
    return await _authRepository.login(loginRequestBody);
  }
}