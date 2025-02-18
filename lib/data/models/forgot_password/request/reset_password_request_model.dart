class ResetPasswordRequestModel {
  final String email;
  final String newPassword;

  ResetPasswordRequestModel({required this.email, required this.newPassword});

  Map<String, dynamic> toJson() => {
    'email': email,
    'newPassword': newPassword,
  };
}