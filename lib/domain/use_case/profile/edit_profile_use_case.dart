import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/api/api_result.dart';
import '../../../core/local/token_manger.dart';
import '../../../data/models/edit_profile/edit_profile_request_model.dart';
import '../../../data/models/edit_profile/edit_profile_response_model.dart';
import '../../repository/auth_repository/auth_repository.dart';

@injectable
class EditProfileUseCase {
  final AuthRepository _authRepository;
  final Dio _dio;

  EditProfileUseCase(this._authRepository)
      : _dio = Dio(BaseOptions(
    baseUrl: "https://fitness.elevateegy.com/",
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  ));

  Future<Result<EditProfileResponseModel>> invoke(EditProfileRequestModel requestModel) async {
    try {
      // Get the token directly
      final token = await TokenManager.getToken();
      if (token == null || token.isEmpty) {
        return Fail(exception: Exception("Authorization token is missing. Please log in again."));
      }

      // Make a direct request with the token
      final response = await _dio.put(
        "api/v1/auth/editProfile",
        data: requestModel.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(data: EditProfileResponseModel.fromJson(response.data));
      } else {
        return Fail(exception: Exception("Failed to update profile: ${response.statusMessage}"));
      }
    } catch (e) {
      return Fail(exception: e is Exception ? e : Exception("Failed to update profile: $e"));
    }
  }
}