import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(Exception error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection to server failed");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout with the server");
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
              message: "Receive timeout in connection with the server");
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
              message: "Send timeout in connection with the server");
        case DioExceptionType.badCertificate:
          return ApiErrorModel(
              message:
                  "The server's certificate is not trusted. Please check your network security.");
        case DioExceptionType.unknown:
          return ApiErrorModel(
              message:
                  "Connection to the server failed due to internet connection");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.statusCode, error.response?.data);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled");

        default:
          return ApiErrorModel(message: error.message);
      }
    } else if (error is IOException) {
      return ApiErrorModel(message: "No internet connection");
    } else {
      return ApiErrorModel(message: "Unknown error occurred");
    }
  }
}

ApiErrorModel _handleError(int? statusCode, dynamic data) {
  String errorMsg = "Unknown error occurred";
  int? resolvedStatusCode;

  if (data is Map) {
    if (data.containsKey("error")) {
      errorMsg = data["error"];
    } else if (data.containsKey("message")) {
      errorMsg = data["message"];
    }

    // Safely parse statusCode
    if (data.containsKey("code")) {
      resolvedStatusCode = (data['code'] is int)
          ? data['code']
          : int.tryParse(data['code'].toString());
    }
  }

  return ApiErrorModel(
    statusCode: resolvedStatusCode ?? statusCode,
    message: errorMsg,
  );
}
