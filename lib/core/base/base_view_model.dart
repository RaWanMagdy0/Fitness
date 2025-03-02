import 'package:flutter_bloc/flutter_bloc.dart';

import '../errors/api_error_handler.dart';
import '../errors/api_error_model.dart';

class BaseViewModel<T> extends Cubit<T> {
  BaseViewModel(super.initialState);

  String getErrorMassageFromException(Exception? exception) {
    final ApiErrorModel apiErrorModel =
        ApiErrorHandler.handle(exception ?? Exception());
    return apiErrorModel.message ??
        "An unknown error occurred. Please try again";
    // if (exception is DioException) {
    //   return _mapDioExceptionToMessage(exception);
    // } else {
    //   return exception!.toString();
    // }
  }

  // String _mapDioExceptionToMessage(DioException dioException) {
  //   switch (dioException.type) {
  //     case DioExceptionType.connectionTimeout:
  //       return AppStringErrors.connectionTimeout;
  //     case DioExceptionType.sendTimeout:
  //       return AppStringErrors.sendTimeout;
  //     case DioExceptionType.receiveTimeout:
  //       return AppStringErrors.receiveTimeout;
  //     case DioExceptionType.badCertificate:
  //       return AppStringErrors.badCertificate;
  //     case DioExceptionType.badResponse:
  //       return _handleBadResponse(dioException);
  //     case DioExceptionType.connectionError:
  //       return AppStringErrors.connectionError;
  //     case DioExceptionType.unknown:
  //       return AppStringErrors.unknown;
  //     case DioExceptionType.cancel:
  //       return dioException.message ?? 'Request cancelled';
  //     default:
  //       return AppStringErrors.unknown;
  //   }
  // }

  /*
  else if (statusCode == 403) {
      return AppStringErrors.unauthorized;
    } else if (statusCode == 401) {
      return AppStringErrors.invalidCredentials;
    }*/

  // String _handleBadResponse(DioException exception) {
  //   final statusCode = exception.response?.statusCode;
  //   final responseData = exception.response?.data;
  //   if (responseData is Map && responseData.containsKey("error")) {
  //     return responseData["error"];
  //   } else if (responseData is Map && responseData.containsKey("message")) {
  //     return responseData["message"];
  //   }
  //   if (statusCode == 400) {
  //     return AppStringErrors.badRequest;
  //   } else if (statusCode == 401 || statusCode == 403) {
  //     return AppStringErrors.unauthorized;
  //   } else if (statusCode == 404) {
  //     return AppStringErrors.notFound;
  //   } else if (statusCode == 409) {
  //     return AppStringErrors.conflict;
  //   } else if (statusCode == 500) {
  //     return AppStringErrors.internalServerError;
  //   } else {
  //     return AppStringErrors.unknown;
  //   }
  // }
}
