class ChangePasswordRequestModel {
  final String password;
  final String newPassword;

  ChangePasswordRequestModel({
    required this.password,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'password': password,
    'newPassword': newPassword,
  };
}