import 'package:dio/dio.dart';

import '../../local/token_manger.dart';
import '../../utils/const/app_const.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await TokenManager.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers[AppConst.authHeaderTokenKey] = 'Bearer $token';
      } else {
        handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.cancel,
            message: 'Authorization token is missing. Please log in.',
          ),
        );
        return;
      }
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          message: 'Failed to retrieve token: $e',
        ),
      );
      return;
    }

    handler.next(options);
  }
}
