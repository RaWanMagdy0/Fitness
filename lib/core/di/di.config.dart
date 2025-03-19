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
import '../../data/api/home_api/home_api_magager.dart' as _i968;
import '../../data/api/meal/meal_api_manager.dart' as _i1065;
import '../../data/api/profile_api/profile_api_manager.dart' as _i592;
import '../../data/api/workout/workout_api_manager.dart' as _i772;
import '../../data/data_source/auth_data_source/auth_remote_data_source.dart'
    as _i249;
import '../../data/data_source/auth_data_source/auth_remote_data_source_impl.dart'
    as _i1001;
import '../../data/data_source/home_data_source/home_remote_data_source.dart'
    as _i753;
import '../../data/data_source/home_data_source/home_remote_data_source_impl.dart'
    as _i1016;
import '../../data/data_source/meal_remote_data_source/meal_remote_data_source.dart'
    as _i1034;
import '../../data/data_source/meal_remote_data_source/meal_remote_data_source_impl.dart'
    as _i222;
import '../../data/data_source/profile_data_source/profile_remote_data_source.dart'
    as _i2;
import '../../data/data_source/profile_data_source/profile_remote_data_source_impl.dart'
    as _i715;
import '../../data/data_source/workout_data_source/workout_remote_data_source.dart'
    as _i1064;
import '../../data/data_source/workout_data_source/workout_remote_data_source_impl.dart'
    as _i990;
import '../../data/repository/auth_repository/auth_repository_impl.dart'
    as _i313;
import '../../data/repository/home_repository/home_repository_impl.dart'
    as _i117;
import '../../data/repository/meal_repository/meal_repo_impl.dart' as _i428;
import '../../data/repository/profile_repository/profile_repository_impl.dart'
    as _i677;
import '../../data/repository/workout_repository/workout_repository_impl.dart'
    as _i606;
import '../../domain/repository/auth_repository/auth_repository.dart' as _i1056;
import '../../domain/repository/home_repository/home_repository.dart' as _i97;
import '../../domain/repository/meal_repository/meal_repo.dart' as _i453;
import '../../domain/repository/profile_repository/profile_repository.dart'
    as _i265;
import '../../domain/repository/workout_repository/workout_repository.dart'
    as _i476;
import '../../domain/use_case/auth/edit_profile_use_case.dart' as _i606;
import '../../domain/use_case/auth/logout_use_case.dart' as _i755;
import '../../domain/use_case/auth/sign_up_use_case.dart' as _i322;
import '../../domain/use_case/home/exercise_use_case.dart' as _i168;
import '../../domain/use_case/home/muscle_group_by_id.dart' as _i603;
import '../../domain/use_case/home/random_muscle_use_case.dart' as _i888;
import '../../domain/use_case/meal/meal_details_use_case.dart' as _i893;
import '../../domain/use_case/meal/meals_tabs_use_case.dart' as _i954;
import '../../domain/use_case/meal/meals_use_case.dart' as _i731;
import '../../domain/use_case/profile/edit_profile_use_case.dart' as _i11;
import '../../domain/use_case/profile/profile_use_case.dart' as _i679;
import '../../domain/use_case/profile/upload_photo_use_case.dart' as _i659;
import '../../domain/use_case/workout/get_muscle_group_details_use_case.dart'
    as _i473;
import '../../domain/use_case/workout/get_muscle_groups_use_case.dart' as _i789;
import '../../presentation/auth/forgot_password/cubit/forgot_password_cubit.dart'
    as _i401;
import '../../presentation/auth/login/view_model/login_cubit.dart' as _i97;
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart' as _i140;
import '../../presentation/edit_profile/view_model/edit_profile_cubit.dart'
    as _i236;
import '../../presentation/home/exercise_screen/view_model/exercise_view_model.dart'
    as _i810;
import '../../presentation/home/home_screen/view_model/home_cubit.dart'
    as _i915;
import '../../presentation/home/workout/view_model/workout_cubit.dart' as _i352;
import '../../presentation/meal/view_model/meal_details_cubit.dart' as _i360;
import '../../presentation/meal/view_model/meals_view_model.dart' as _i448;
import '../../presentation/online_coach/view_model/smart_coach_cubit.dart'
    as _i721;
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
    gh.lazySingleton<_i968.HomeApiManager>(
        () => _i968.HomeApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i1065.MealApiManager>(
        () => _i1065.MealApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i592.ProfileApiManager>(
        () => _i592.ProfileApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i772.WorkoutApiManager>(
        () => _i772.WorkoutApiManager(gh<_i361.Dio>()));
    gh.factory<_i2.ProfileRemoteDataSource>(() =>
        _i715.ProfileRemoteDataSourceImpl(
            profileApiManager: gh<_i592.ProfileApiManager>()));
    gh.factory<_i1064.WorkoutRemoteDataSource>(() =>
        _i990.WorkoutRemoteDataSourceImpl(
            workoutApiManager: gh<_i772.WorkoutApiManager>()));
    gh.factory<_i476.WorkoutRepository>(() => _i606.WorkoutRepositoryImpl(
        workoutRemoteDataSource: gh<_i1064.WorkoutRemoteDataSource>()));
    gh.factory<_i753.HomeRemoteDataSource>(
        () => _i1016.HomeRemoteDataSourceImpl(gh<_i968.HomeApiManager>()));
    gh.factory<_i249.AuthRemoteDataSource>(() =>
        _i1001.AuthRemoteDataSourceImpl(
            authApiManager: gh<_i515.AuthApiManager>()));
    gh.factory<_i1034.MealRemoteDataSource>(() =>
        _i222.MealRemoteDataSourceImpl(
            mealApiManager: gh<_i1065.MealApiManager>()));
    gh.factory<_i265.ProfileRepository>(() => _i677.ProfileRepositoryImpl(
        profileRemoteDataSource: gh<_i2.ProfileRemoteDataSource>()));
    gh.factory<_i97.HomeRepository>(
        () => _i117.HomeRepositoryImpl(gh<_i753.HomeRemoteDataSource>()));
    gh.factory<_i721.GeminiCubit>(
        () => _i721.GeminiCubit(gh<_i265.ProfileRepository>()));
    gh.factory<_i168.ExerciseUseCase>(
        () => _i168.ExerciseUseCase(gh<_i97.HomeRepository>()));
    gh.factory<_i603.MuscleGroupByIdUseCase>(
        () => _i603.MuscleGroupByIdUseCase(gh<_i97.HomeRepository>()));
    gh.factory<_i888.RandomMuscleUseCase>(
        () => _i888.RandomMuscleUseCase(gh<_i97.HomeRepository>()));
    gh.factory<_i679.ProfileUseCase>(
        () => _i679.ProfileUseCase(gh<_i265.ProfileRepository>()));
    gh.factory<_i659.UploadPhotoUseCase>(
        () => _i659.UploadPhotoUseCase(gh<_i265.ProfileRepository>()));
    gh.factory<_i453.MealRepository>(
        () => _i428.MealRepositoryImpl(gh<_i1034.MealRemoteDataSource>()));
    gh.factory<_i789.GetMuscleGroupsUseCase>(
        () => _i789.GetMuscleGroupsUseCase(gh<_i476.WorkoutRepository>()));
    gh.factory<_i473.GetMuscleGroupDetailsUseCase>(() =>
        _i473.GetMuscleGroupDetailsUseCase(gh<_i476.WorkoutRepository>()));
    gh.factory<_i1056.AuthRepository>(() => _i313.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i249.AuthRemoteDataSource>()));
    gh.factory<_i893.MealDetailsUseCase>(
        () => _i893.MealDetailsUseCase(gh<_i453.MealRepository>()));
    gh.factory<_i810.ExerciseViewModel>(
        () => _i810.ExerciseViewModel(gh<_i168.ExerciseUseCase>()));
    gh.factory<_i954.MealsTabsUseCase>(
        () => _i954.MealsTabsUseCase(gh<_i453.MealRepository>()));
    gh.factory<_i731.MealsUseCase>(
        () => _i731.MealsUseCase(gh<_i453.MealRepository>()));
    gh.factory<_i606.EditProfileUseCase>(
        () => _i606.EditProfileUseCase(gh<_i1056.AuthRepository>()));
    gh.factory<_i322.SignupUseCase>(
        () => _i322.SignupUseCase(gh<_i1056.AuthRepository>()));
    gh.factory<_i11.EditProfileUseCase>(
        () => _i11.EditProfileUseCase(gh<_i1056.AuthRepository>()));
    gh.factory<_i97.LoginCubit>(
        () => _i97.LoginCubit(gh<_i1056.AuthRepository>()));
    gh.factory<_i448.MealsViewModel>(() => _i448.MealsViewModel(
          gh<_i954.MealsTabsUseCase>(),
          gh<_i731.MealsUseCase>(),
        ));
    gh.factory<_i755.LogoutUseCase>(
        () => _i755.LogoutUseCase(gh<_i1056.AuthRepository>()));
    gh.factory<_i352.WorkoutCubit>(() => _i352.WorkoutCubit(
          gh<_i789.GetMuscleGroupsUseCase>(),
          gh<_i473.GetMuscleGroupDetailsUseCase>(),
        ));
    gh.factory<_i360.MealDetailsCubit>(
        () => _i360.MealDetailsCubit(gh<_i893.MealDetailsUseCase>()));
    gh.factory<_i915.HomeCubit>(() => _i915.HomeCubit(
          gh<_i789.GetMuscleGroupsUseCase>(),
          gh<_i954.MealsTabsUseCase>(),
          gh<_i888.RandomMuscleUseCase>(),
          gh<_i603.MuscleGroupByIdUseCase>(),
        ));
    gh.factory<_i401.ForgotPasswordCubit>(() =>
        _i401.ForgotPasswordCubit(authRepository: gh<_i1056.AuthRepository>()));
    gh.factory<_i821.ProfileCubit>(() => _i821.ProfileCubit(
          gh<_i679.ProfileUseCase>(),
          gh<_i755.LogoutUseCase>(),
          gh<_i659.UploadPhotoUseCase>(),
        ));
    gh.factory<_i140.SignUpCubit>(
        () => _i140.SignUpCubit(gh<_i322.SignupUseCase>()));
    gh.factory<_i236.EditProfileCubit>(
        () => _i236.EditProfileCubit(gh<_i606.EditProfileUseCase>()));
    return this;
  }
}

class _$DioModule extends _i223.DioModule {}
