import 'dart:io';

import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/domain/entity/profile/user.dart';
import 'package:fitness_app/domain/repository/profile_repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final ProfileRepository _profileRepository;

  UploadPhotoUseCase(this._profileRepository);

  Future<Result<User?>> invoke(File photo) async {
    return await _profileRepository.uploadPhoto(photo);
  }
}