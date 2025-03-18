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
      // Check if the request already has an Authorization header
      if (options.headers.containsKey(AppConst.authHeaderTokenKey)) {
        // Authorization header already exists, let the request continue
        return handler.next(options);
      }

      // No Authorization header yet, try to get the token
      final token = await TokenManager.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers[AppConst.authHeaderTokenKey] = 'Bearer $token';
        print("🔑 Added token to request: ${options.path}");
        return handler.next(options);
      }

      // If we reach here, there's no token and we need one
      if (_isAuthRequiredEndpoint(options.path)) {
        throw DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          message: 'Authorization token is missing. Please log in.',
        );
      } else {
        // For endpoints that don't require auth, let it pass through
        return handler.next(options);
      }
    } catch (e) {
      print("❌ Token error: $e");
      handler.reject(
        e is DioException ? e : DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          message: 'Failed to retrieve token: $e',
        ),
      );
    }
  }

  bool _isAuthRequiredEndpoint(String path) {
    // List of endpoints that require authentication
    final authRequiredEndpoints = [
      '/api/v1/auth/profile-data',
      '/api/v1/auth/editProfile',
      // Add other protected endpoints here
    ];

    return authRequiredEndpoints.any((endpoint) => path.contains(endpoint));
  }
}