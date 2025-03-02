class ForgotPasswordResponseModel {
  final String? message;
  final String? info;

  ForgotPasswordResponseModel({this.message, this.info});

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      message: json['message'],
      info: json['info'],
    );
  }
}