import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/core/api/execute_api_call.dart';
import 'package:fitness_app/data/api/auth_api/auth_api_manager.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import 'package:injectable/injectable.dart';
import '../../../core/local/token_manger.dart' show TokenManager;
import '../../models/edit_profile/edit_profile_request_model.dart' show EditProfileRequestModel;
import '../../models/edit_profile/edit_profile_response_model.dart' show EditProfileResponseModel;
import '../../models/forgot_password/request/forgot_password_request_model.dart' show ForgotPasswordRequestModel;
import '../../models/forgot_password/request/reset_password_request_model.dart' show ResetPasswordRequestModel;
import '../../models/forgot_password/request/verify_code_request_model.dart' show VerifyCodeRequestModel;
import '../../models/login/request/login_request_model.dart' show LoginRequestModel;
import 'auth_remote_data_source.dart';


@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiManager authApiManager;

  AuthRemoteDataSourceImpl({required this.authApiManager});
  @override
  Future<Result<String?>> signUp(SignupRequestBody signupRequestBody) {
    return executeApiCall<String?>(()async{
      final response=await authApiManager.signUp(signupRequestBody);
      return response.message;
    }
    );
  }
  @override
  Future<Result<String?>> login(LoginRequestModel loginRequestModel) {
    return executeApiCall<String?>(() async {
      final response = await authApiManager.login(loginRequestModel);
      if (response.token != null) {
        await TokenManager.setToken(token: response.token!);
      }
      return response.message;
    });
  }

  @override
  Future<Result<EditProfileResponseModel>> editProfile(EditProfileRequestModel requestModel) {
    return executeApiCall<EditProfileResponseModel>(() async {
      final response = await authApiManager.editProfile(requestModel);
      return response;
    });
  }
  @override
  Future<Result<String?>> forgotPassword(ForgotPasswordRequestModel requestModel) {
    return executeApiCall<String?>(() async {
      final response = await authApiManager.forgotPassword(requestModel);
      return response.message;
    });
  }

  @override
  Future<Result<String?>> verifyResetCode(VerifyCodeRequestModel requestModel) {
    return executeApiCall<String?>(() async {
      final response = await authApiManager.verifyResetCode(requestModel);
      return response.message;
    });
  }

  @override
  Future<Result<String?>> resetPassword(ResetPasswordRequestModel requestModel) {
    return executeApiCall<String?>(() async {
      final response = await authApiManager.resetPassword(requestModel);
      return response.message;
    });

  }

}

