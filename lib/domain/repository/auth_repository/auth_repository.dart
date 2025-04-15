import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';

import '../../../data/models/edit_profile/edit_profile_request_model.dart'
    show EditProfileRequestModel;
import '../../../data/models/edit_profile/edit_profile_response_model.dart'
    show EditProfileResponseModel;
import '../../../data/models/forgot_password/request/forgot_password_request_model.dart'
    show ForgotPasswordRequestModel;
import '../../../data/models/forgot_password/request/reset_password_request_model.dart'
    show ResetPasswordRequestModel;
import '../../../data/models/forgot_password/request/verify_code_request_model.dart'
    show VerifyCodeRequestModel;
import '../../../data/models/login/request/login_request_model.dart'
    show LoginRequestModel;

abstract class AuthRepository {
  Future<Result<String?>> signUp(SignupRequestBody signupRequestBody);
  Future<Result<String?>> login(LoginRequestModel loginRequestModel);
  Future<Result<String?>> forgotPassword(
      ForgotPasswordRequestModel requestModel);
  Future<Result<String?>> verifyResetCode(VerifyCodeRequestModel requestModel);
  Future<Result<String?>> resetPassword(ResetPasswordRequestModel requestModel);
  Future<Result<String?>> editProfile(
      EditProfileRequestModel requestModel);
  Future<Result<String?>> logout();
}