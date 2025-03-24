import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
import '../../models/edit_profile/edit_profile_response_model.dart';
import '../../models/profile/change_password_request_model.dart';
import '../../models/profile/profile_response_model.dart';
part 'profile_api_manager.g.dart';

@lazySingleton
@RestApi()
abstract class ProfileApiManager {
  @factoryMethod
  factory ProfileApiManager(Dio dio) = _ProfileApiManager;

  @GET(ApiConstants.profile)
  Future<ProfileResponseModel> getUserData(
    @Header('Authorization') String token,

  );
  @POST(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyAnk5HA9qvIe-bh_Faczk-lRTebDg5n6q0")
  Future<String> smartCoach(
    @Body() Map<String, dynamic> message,
  );

  @MultiPart()
  @PUT(ApiConstants.uploadPhoto)
  Future<EditProfileResponseModel> uploadPhoto(
    @Part(name: 'photo') File photo,
  );
  @PATCH(ApiConstants.changePassword)
  Future<String?> changePassword(
      @Body() ChangePasswordRequestModel request,
      @Header('Authorization') String token,
      );
}
