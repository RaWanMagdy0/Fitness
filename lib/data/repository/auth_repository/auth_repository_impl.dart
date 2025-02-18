import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/auth_data_source/auth_remote_data_source.dart';

import 'package:injectable/injectable.dart';

import '../../../domain/repository/auth_repository/auth_repository.dart';
import '../../models/forgot_password/request/forgot_password_request_model.dart' show ForgotPasswordRequestModel;
import '../../models/forgot_password/request/reset_password_request_model.dart' show ResetPasswordRequestModel;
import '../../models/forgot_password/request/verify_code_request_model.dart' show VerifyCodeRequestModel;
import '../../models/login/request/login_request_model.dart' show LoginRequestModel;
import '../../models/sign_up/request/sign_up_request_body.dart' show SignupRequestBody;

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Result<String?>> signUp(SignupRequestBody signupRequestBody) {
    final response = authRemoteDataSource.signUp(signupRequestBody);
    return response;
  }
  @override
  Future<Result<String?>> login(LoginRequestModel loginRequestModel) {
    return authRemoteDataSource.login(loginRequestModel);
  }

  @override
  Future<Result<String?>> forgotPassword(ForgotPasswordRequestModel requestModel) {
    return authRemoteDataSource.forgotPassword(requestModel);
  }

  @override
  Future<Result<String?>> verifyResetCode(VerifyCodeRequestModel requestModel) {
    return authRemoteDataSource.verifyResetCode(requestModel);
  }

  @override
  Future<Result<String?>> resetPassword(ResetPasswordRequestModel requestModel) {
    return authRemoteDataSource.resetPassword(requestModel);
  }
}
