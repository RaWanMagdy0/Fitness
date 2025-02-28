import 'user_model.dart';

class ProfileResponseModel {
  ProfileResponseModel({
      this.message, 
      this.user,});

  ProfileResponseModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
  String? message;
  UserModel? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}