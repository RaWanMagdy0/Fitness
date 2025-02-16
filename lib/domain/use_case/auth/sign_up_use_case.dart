import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import 'package:fitness_app/domain/repository/auth_repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUseCase {
  final AuthRepository _authRepository;
  SignupUseCase(this._authRepository);
  Future<Result<String?>> invoke(SignupRequestBody signupRequestBody) async {
    return await _authRepository.signUp(signupRequestBody);
  }
}
