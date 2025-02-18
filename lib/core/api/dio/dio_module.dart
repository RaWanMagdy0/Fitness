import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dio_factory.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(DioFactory dioFactory) => dioFactory.createDio();
}
