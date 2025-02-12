import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import '../../../core/api/api_result.dart';

abstract class AuthRemoteDataSource{
  Future<Result<String?>> signUp(SignupRequestBody signupRequestBody);
}