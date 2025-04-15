import 'package:fitness_app/domain/use_case/profile/profile_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api/api_result.dart';
import '../../../../../../core/base/base_view_model.dart';
import '../../../domain/entity/profile/user.dart';
import '../../../domain/use_case/auth/logout_use_case.dart';
import '../../../domain/use_case/profile/upload_photo_use_case.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends BaseViewModel<ProfileState> {
  final ProfileUseCase profileUseCase;
  final LogoutUseCase logoutUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  ProfileCubit(
    this.profileUseCase,
    this.logoutUseCase,
    this._uploadPhotoUseCase,
  ) : super(ProfileInitialState());

  String? userImage;
  String? userName;

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    var result = await profileUseCase.invoke();
    switch (result) {
      case Success<User?>():
        var user = result.data;
        userImage = user?.photo;
        userName = user?.firstName;
        print("Updated User Image: $userImage");
        emit(GetUserDataSuccessState(user: user));
      case Fail<User?>():
        emit(GetUserDataErrorState(
            errorMessage: getErrorMassageFromException(result.exception)));
    }
  }

  Future<void> logout() async {
    final response = await logoutUseCase.invoke();
    switch (response) {
      case Success<String?>():
        await secureStorage.delete(key: 'token');
        emit(LogoutSuccessState(response.data));
      case Fail<String?>():
        emit(
            LogoutErrorState(getErrorMassageFromException(response.exception)));
    }
  }
}
