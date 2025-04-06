import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../entity/profile/user.dart';
import '../../repository/profile_repository/profile_repository.dart';

@injectable
class UploadPhotoUseCase {
  final ProfileRepository _profileRepository;

  UploadPhotoUseCase(this._profileRepository);

  Future<Result<String?>> invoke(File photo) {
    return _profileRepository.uploadPhoto(photo);
  }
}