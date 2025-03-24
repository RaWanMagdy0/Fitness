import 'dart:io' show File;

import '../../../core/api/api_result.dart';
import '../../entity/profile/user.dart';

abstract class ProfileRepository{
  Future<Result<User?>>getUserData();
  Future<Result<User?>> uploadPhoto(File photo);
  Future<Result<String?>>smartCoach(Map<String, dynamic> message);
  Future<Result<String?>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

}