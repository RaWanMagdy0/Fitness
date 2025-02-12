class ApiErrorModel {
  dynamic statusCode;
  String? message;

  ApiErrorModel({
    this.statusCode,
    required this.message,
  });
}
