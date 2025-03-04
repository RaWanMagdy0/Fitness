import '../../../core/api/api_result.dart';
import '../../entity/profile/user.dart';

abstract class ProfileRepository{
  Future<Result<User?>>getUserData();
  Future<Result<String?>>smartCoach(Map<String, dynamic> message);

}