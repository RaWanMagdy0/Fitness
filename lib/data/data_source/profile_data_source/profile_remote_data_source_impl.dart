import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fitness_app/core/api/api_const.dart';
import 'package:fitness_app/core/api/api_result.dart';
import 'package:fitness_app/core/api/execute_api_call.dart';
import 'package:fitness_app/data/api/profile_api/profile_api_manager.dart';
import 'package:fitness_app/data/data_source/profile_data_source/profile_remote_data_source.dart';
import 'package:fitness_app/data/models/edit_profile/edit_profile_response_model.dart';
import 'package:fitness_app/data/models/profile/user_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import '../../../core/local/token_manger.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiManager profileApiManager;
  final Dio _dio;

  ProfileRemoteDataSourceImpl({required this.profileApiManager})
      : _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    headers: {
      "Cache-Control": "no-cache",
      "Pragma": "no-cache",
    },
  ));

  @override
  Future<Result<UserModel?>> getUserData() {
    return executeApiCall<UserModel?>(() async {
      var token = await _getToken();
      final response = await profileApiManager.getUserData(token);
      return response.user;
    });
  }

  @override
  Future<Result<UserModel?>> uploadPhoto(File photo) async {
    try {
      // Get the token
      var token = await _getToken();

      // Create multipart request
      final fileName = photo.path.split('/').last;
      final fileExtension = fileName.split('.').last.toLowerCase();

      // Verify file extension is an image type
      if (!['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
        return Fail(exception: Exception("Only image files (jpg, png, gif) are allowed"));
      }

      // Create form data
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: fileName,
          contentType: MediaType('image', fileExtension == 'jpg' ? 'jpeg' : fileExtension),
        ),
      });

      // Make the API call with authentication
      final response = await _dio.put(
        ApiConstants.uploadPhoto,
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
          },
          followRedirects: true,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = EditProfileResponseModel.fromJson(response.data);
        return Success(data: responseData.user);
      } else {
        return Fail(exception: Exception("Failed to upload image: ${response.statusCode}"));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Fail(exception: Exception("Unauthorized. Please login again."));
      } else if (e.response?.data != null && e.response?.data is Map) {
        final error = e.response?.data["error"] ?? "Unknown error";
        return Fail(exception: Exception("Failed to upload image: $error"));
      } else {
        return Fail(exception: Exception("Network error: ${e.message}"));
      }
    } on Exception catch (e) {
      return Fail(exception: e);
    }
  }

  Future<String> _getToken() async {
    var token = await TokenManager.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token is missing. Please login again.");
    }
    return 'Bearer $token';
  }

  @override
  Future<Result<String?>> smartCoach(Map<String, dynamic> message) {
    return executeApiCall<String?>(() async {
      final response = await profileApiManager.smartCoach(message);
      return response;
    });
  }
}