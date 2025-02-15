import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/core/api/execute_api_call.dart';
import 'package:fitness_app/data/api/auth_api/auth_api_manager.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import 'package:injectable/injectable.dart';
import '../../models/login/request/login_request_model.dart' show LoginRequestModel;
import 'auth_remote_data_source.dart';


@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  AuthApiManager authApiManager;
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
  Future<Result<String?>> login(LoginRequestModel loginRequestBody) {
    return executeApiCall<String?>(() async {
      final response = await authApiManager.login(loginRequestBody);
      return response.message;
    });
  }

}