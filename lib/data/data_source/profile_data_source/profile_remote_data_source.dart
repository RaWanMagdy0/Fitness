import 'dart:io' show File;

import '../../../core/api/api_result.dart';
import '../../models/profile/user_model.dart';

abstract class ProfileRemoteDataSource{
  Future<Result<UserModel?>> getUserData();
  Future<Result<UserModel?>> uploadPhoto(File photo);

}