
import 'package:fitness_app/data/models/sign_up/response/user_model.dart';

class SignUpResponseModel {
  SignUpResponseModel({
      this.message, 
      this.user, 
      this.token,});

  SignUpResponseModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  UserModel? user;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }

}