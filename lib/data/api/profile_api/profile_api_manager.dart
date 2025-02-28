import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/api/api_const.dart';
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
}
