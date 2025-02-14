// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api/auth_api/auth_api_manager.dart' as _i515;
import '../../data/data_source/auth_data_source/auth_remote_data_source.dart'
    as _i249;
import '../../data/data_source/auth_data_source/auth_remote_data_source_impl.dart'
    as _i1001;
import '../../data/repository/auth_repository/auth_repository_impl.dart'
    as _i313;
import '../../domain/repository/auth_repository/auth_repository.dart' as _i1056;
import '../api/dio/dio_factory.dart' as _i763;
import '../api/dio/dio_module.dart' as _i223;
import '../utils/functions/providers/app_provider.dart' as _i240;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i763.DioFactory>(() => _i763.DioFactory());
    gh.singleton<_i240.AppProvider>(() => _i240.AppProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i515.AuthApiManager>(
      () => _i515.AuthApiManager(gh<_i361.Dio>()),
    );
    gh.factory<_i249.AuthRemoteDataSource>(
      () => _i1001.AuthRemoteDataSourceImpl(
        authApiManager: gh<_i515.AuthApiManager>(),
      ),
    );
    gh.factory<_i1056.AuthRepository>(
      () => _i313.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i249.AuthRemoteDataSource>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}
