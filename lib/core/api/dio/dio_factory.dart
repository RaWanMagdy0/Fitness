import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api_const.dart';
import 'token_interceptor.dart';

@injectable
class DioFactory {
  DioFactory();

  Duration get _timeout => const Duration(seconds: 60);

  @factoryMethod
  Dio createDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      validateStatus: (status) =>
          status != null ? status == 200 || status == 201 : false,
    );
    addFreeDioInterceptors(dio);
    return dio;
  }

  @factoryMethod
  Dio createTokenDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      validateStatus: (status) => status != null ? status <= 500 : false,
    );
    addTokenDioInterceptors(dio);
    return dio;
  }

  void addFreeDioInterceptors(Dio dio) {
    dio.interceptors.addAll(
      [
        !kReleaseMode
            ? PrettyDioLogger(
                requestBody: true,
                requestHeader: true,
                responseHeader: true,
              )
            : const Interceptor(),
      ],
    );
  }

  void addTokenDioInterceptors(Dio dio) {
    dio.interceptors.addAll(
      [
        TokenInterceptor(),
        !kReleaseMode
            ? PrettyDioLogger(
                requestBody: true,
                requestHeader: true,
                responseHeader: true,
              )
            : const Interceptor(),
      ],
    );
  }
}
