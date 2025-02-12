import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_factory.dart';

@module
abstract class DioModule {
  // @Named(AppConst.freeDioKey)
  @lazySingleton
  Dio get dio => DioFactory().createDio();

  // @Named(AppConst.tokenDioKey)
  // @lazySingleton
  // Dio get tokenDio => DioFactory().createTokenDio();
}
