import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../data/models/edit_profile/edit_profile_request_model.dart' show EditProfileRequestModel;
import '../../../data/models/edit_profile/edit_profile_response_model.dart' show EditProfileResponseModel;
import '../../repository/auth_repository/auth_repository.dart';

@injectable
class EditProfileUseCase {
  final AuthRepository _authRepository;

  EditProfileUseCase(this._authRepository);

  Future<Result<String?>> invoke(EditProfileRequestModel requestModel) {
    return _authRepository.editProfile(requestModel);
  }
}