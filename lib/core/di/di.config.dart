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
import '../../data/api/profile_api/profile_api_manager.dart' as _i592;
import '../../data/data_source/auth_data_source/auth_remote_data_source.dart'
    as _i249;
import '../../data/data_source/auth_data_source/auth_remote_data_source_impl.dart'
    as _i1001;
import '../../data/data_source/profile_data_source/profile_remote_data_source.dart'
    as _i2;
import '../../data/data_source/profile_data_source/profile_remote_data_source_impl.dart'
    as _i715;
import '../../data/repository/auth_repository/auth_repository_impl.dart'
    as _i313;
import '../../data/repository/profile_repository/profile_repository_impl.dart'
    as _i677;
import '../../domain/repository/auth_repository/auth_repository.dart' as _i1056;
import '../../domain/repository/profile_repository/profile_repository.dart'
    as _i265;
import '../../domain/use_case/auth/sign_up_use_case.dart' as _i322;
import '../../domain/use_case/profile/profile_use_case.dart' as _i679;
import '../../presentation/auth/forgot_password/cubit/forgot_password_cubit.dart'
    as _i401;
import '../../presentation/auth/login/view_model/login_cubit.dart' as _i97;
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart' as _i140;
import '../../presentation/profile/view_model/profile_cubit.dart' as _i821;
import '../api/dio/dio_factory.dart' as _i763;
import '../api/dio/dio_module.dart' as _i223;
import '../api/dio/token_interceptor.dart' as _i683;
import '../utils/functions/providers/app_provider.dart' as _i240;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i763.DioFactory>(() => _i763.DioFactory());
    gh.factory<_i683.TokenInterceptor>(() => _i683.TokenInterceptor());
    gh.singleton<_i240.AppProvider>(() => _i240.AppProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio(gh<_i763.DioFactory>()));
    gh.lazySingleton<_i515.AuthApiManager>(
        () => _i515.AuthApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i592.ProfileApiManager>(
        () => _i592.ProfileApiManager(gh<_i361.Dio>()));
    gh.factory<_i2.ProfileRemoteDataSource>(() =>
        _i715.ProfileRemoteDataSourceImpl(
            profileApiManager: gh<_i592.ProfileApiManager>()));
    gh.factory<_i249.AuthRemoteDataSource>(() =>
        _i1001.AuthRemoteDataSourceImpl(
            authApiManager: gh<_i515.AuthApiManager>()));
    gh.factory<_i265.ProfileRepository>(() => _i677.ProfileRepositoryImpl(
        profileRemoteDataSource: gh<_i2.ProfileRemoteDataSource>()));
    gh.factory<_i679.ProfileUseCase>(
        () => _i679.ProfileUseCase(gh<_i265.ProfileRepository>()));
    gh.factory<_i1056.AuthRepository>(() => _i313.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i249.AuthRemoteDataSource>()));
    gh.factory<_i821.ProfileCubit>(
        () => _i821.ProfileCubit(gh<_i679.ProfileUseCase>()));
    gh.factory<_i322.SignupUseCase>(
        () => _i322.SignupUseCase(gh<_i1056.AuthRepository>()));
    gh.factory<_i97.LoginCubit>(
        () => _i97.LoginCubit(gh<_i1056.AuthRepository>()));
    gh.factory<_i401.ForgotPasswordCubit>(() =>
        _i401.ForgotPasswordCubit(authRepository: gh<_i1056.AuthRepository>()));
    gh.factory<_i140.SignUpCubit>(
        () => _i140.SignUpCubit(gh<_i322.SignupUseCase>()));
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}
