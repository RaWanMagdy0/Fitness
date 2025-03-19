import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import '../../../core/api/api_result.dart';
import '../../models/edit_profile/edit_profile_request_model.dart'
    show EditProfileRequestModel;
import '../../models/edit_profile/edit_profile_response_model.dart'
    show EditProfileResponseModel;
import '../../models/forgot_password/request/forgot_password_request_model.dart'
    show ForgotPasswordRequestModel;
import '../../models/forgot_password/request/reset_password_request_model.dart'
    show ResetPasswordRequestModel;
import '../../models/forgot_password/request/verify_code_request_model.dart'
    show VerifyCodeRequestModel;
import '../../models/login/request/login_request_model.dart'
    show LoginRequestModel;

abstract class AuthRemoteDataSource {
  Future<Result<String?>> signUp(SignupRequestBody signupRequestBody);
  Future<Result<String?>> login(LoginRequestModel loginRequestModel);
  Future<Result<String?>> forgotPassword(
      ForgotPasswordRequestModel requestModel);
  Future<Result<String?>> verifyResetCode(VerifyCodeRequestModel requestModel);
  Future<Result<String?>> resetPassword(ResetPasswordRequestModel requestModel);
  Future<Result<EditProfileResponseModel>> editProfile(
      EditProfileRequestModel requestModel);
  Future<Result<String?>> logout();
}