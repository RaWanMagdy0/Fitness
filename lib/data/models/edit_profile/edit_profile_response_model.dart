import '../sign_up/response/user_model.dart' show UserModel;

class EditProfileResponseModel {
  String? message;
  UserModel? user;

  EditProfileResponseModel({
    this.message,
    this.user,
  });

  EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
}