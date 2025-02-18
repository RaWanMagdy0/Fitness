import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart' show injectable;
import '../../local/token_manger.dart';
import '../../utils/const/app_const.dart';

@injectable
class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      final token = await TokenManager.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers[AppConst.authHeaderTokenKey] = 'Bearer $token';
        return handler.next(options);
      }

      throw DioException(
        requestOptions: options,
        type: DioExceptionType.cancel,
        message: 'Authorization token is missing. Please log in.',
      );
    } catch (e) {
      handler.reject(
        e is DioException ? e : DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          message: 'Failed to retrieve token: $e',
        ),
      );
    }
  }
}