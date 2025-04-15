import 'dart:io' show File;

import '../../../core/api/api_result.dart';
import '../../models/profile/user_model.dart';

abstract class ProfileRemoteDataSource{
  Future<Result<UserModel?>> getUserData();
  Future<Result<String?>> uploadPhoto(File photo);
  Future<Result<String?>> smartCoach(Map<String, dynamic> message);
  Future<Result<String?>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

}