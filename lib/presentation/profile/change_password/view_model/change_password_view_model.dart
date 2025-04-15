import 'package:fitness_app/domain/repository/profile_repository/profile_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/api/api_result.dart';
import '../../../../../../core/base/base_view_model.dart';
import 'change_password_state.dart';

@injectable
class ChangePasswordViewModel extends BaseViewModel<ChangePasswordState> {
  final ProfileRepository profileRepository;

  ChangePasswordViewModel(this.profileRepository)
      : super(ChangePasswordInitial());

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await profileRepository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    switch (result) {
      case Success<String?>():
        emit(ChangePasswordSuccess());
      case Fail<String?>():
        emit(ChangePasswordError(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }
}
