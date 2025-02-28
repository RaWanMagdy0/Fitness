import 'package:fitness_app/domain/repository/profile_repository/profile_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../entity/profile/user.dart';

@injectable
class ProfileUseCase {
  final ProfileRepository _profileRepository;
  ProfileUseCase(this._profileRepository);
  Future<Result<User?>> invoke() async {
    return await _profileRepository.getUserData();
  }
}
