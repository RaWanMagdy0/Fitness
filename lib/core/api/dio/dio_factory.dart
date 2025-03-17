import 'package:dio/dio.dart';
import 'package:fitness_app/core/api/dio/token_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api_const.dart';

@injectable
class DioFactory {
  final TokenInterceptor _tokenInterceptor;

  DioFactory(this._tokenInterceptor);

  Duration get _timeout => const Duration(seconds: 60);

  Dio createDio() {
    Dio dio = Dio();

    dio.interceptors.clear();
    dio.close(force: true);

    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: {
          "Cache-Control": "no-cache",
          "Pragma": "no-cache",
        },
        validateStatus: (status) =>
        status != null ? status == 200 || status == 201 : false,
      ),
    );

    // Add the token interceptor to all requests
    dio.interceptors.add(_tokenInterceptor);

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }

    return dio;
  }

  // Create a special Dio instance for endpoints that require authentication
  Dio createAuthDio() {
    final dio = createDio();
    return dio;
  }
}