class VerifyCodeRequestModel {
  final String resetCode;

  VerifyCodeRequestModel({required this.resetCode});

  Map<String, dynamic> toJson() => {'resetCode': resetCode};
}
