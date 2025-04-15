import 'dart:io' show File;

import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/core/api/execute_api_call.dart';
import 'package:fitness_app/data/api/profile_api/profile_api_manager.dart';
import 'package:fitness_app/data/data_source/profile_data_source/profile_remote_data_source.dart';
import 'package:fitness_app/data/models/profile/user_model.dart';
import 'package:injectable/injectable.dart';

import '../../../core/local/token_manger.dart';
import '../../models/profile/change_password_request_model.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiManager profileApiManager;

  ProfileRemoteDataSourceImpl({required this.profileApiManager});

  @override
  Future<Result<UserModel?>> getUserData() {
    return executeApiCall<UserModel?>(() async {
      var token = await _getToken();
      final response = await profileApiManager.getUserData(token);
      return response.user;
    });
  }
  @override
  Future<Result<String?>> uploadPhoto(File photo) {
    return executeApiCall(() async {
      var token = await _getToken();
      var response = await profileApiManager.uploadPhoto(token, photo);
      return response;
    });
  }

  @override
  Future<Result<String?>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return executeApiCall<String?>(() async {
      final token = await TokenManager.getToken();
      final request = ChangePasswordRequestModel(
        password: currentPassword,
        newPassword: newPassword,
      );
      return await profileApiManager.changePassword(
        request,
        'Bearer $token',
      );
    });
  }


  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }

  @override
  Future<Result<String?>> smartCoach(Map<String, dynamic> message) {
    return executeApiCall<String?>(() async {
      final response = await profileApiManager.smartCoach( message);
      return response;
    });
  }
}
