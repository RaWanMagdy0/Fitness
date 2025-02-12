import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';

abstract class AuthRepository{
  Future<Result<String?>>signUp(SignupRequestBody signupRequestBody);
}