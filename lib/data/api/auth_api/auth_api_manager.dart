import 'package:dio/dio.dart';
import 'package:fitness_app/data/models/sign_up/response/sign_up_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api/api_const.dart';
import '../../models/login/request/login_request_model.dart' show LoginRequestModel;
import '../../models/login/response/login_response_model.dart' show LoginResponseModel;
import '../../models/sign_up/request/sign_up_request_body.dart';
part 'auth_api_manager.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiManager {
  @factoryMethod
  factory AuthApiManager(Dio dio) = _AuthApiManager;

  @POST(ApiConstants.signUp)
  Future<SignUpResponseModel> signUp(
    @Body() SignupRequestBody signupRequestBody,
  );

  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(
      @Body() LoginRequestModel loginRequestBody,
      );

}
