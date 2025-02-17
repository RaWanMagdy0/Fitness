import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/data/data_source/auth_data_source/auth_remote_data_source.dart';

import 'package:fitness_app/data/models/sign_up/request/sign_up_request_body.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/auth_repository/auth_repository.dart';
import '../../models/login/request/login_request_model.dart' show LoginRequestModel;

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
  Future<Result<String?>> login(LoginRequestModel loginRequestBody) {
    return authRemoteDataSource.login(loginRequestBody);
  }
}
