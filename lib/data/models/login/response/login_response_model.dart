import '../../sign_up/response/user_model.dart' show UserModel;

class LoginResponseModel {
  final String? message;
  final UserModel? user;
  final String? token;

  LoginResponseModel({this.message, this.user, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      token: json['token'],
    );
  }
}