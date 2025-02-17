import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import '../../../core/api/api_result.dart';
import '../../models/login/request/login_request_model.dart' show LoginRequestModel;

abstract class AuthRemoteDataSource{
  Future<Result<String?>> signUp(SignupRequestBody signupRequestBody);
  Future<Result<String?>> login(LoginRequestModel loginRequestBody);
}