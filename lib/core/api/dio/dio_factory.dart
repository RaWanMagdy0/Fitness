import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api_const.dart';

@injectable
class DioFactory {
  Duration get _timeout => const Duration(seconds: 120);

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
}
