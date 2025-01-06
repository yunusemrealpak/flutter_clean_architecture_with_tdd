// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_clean_architecture/src/core/network/dio_client.dart'
    as _i16;
import 'package:flutter_clean_architecture/src/core/network/dio_client_config.dart'
    as _i4;
import 'package:flutter_clean_architecture/src/core/network/network_info.dart'
    as _i8;
import 'package:flutter_clean_architecture/src/core/network/token/token_provider.dart'
    as _i5;
import 'package:flutter_clean_architecture/src/features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i18;
import 'package:flutter_clean_architecture/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i20;
import 'package:flutter_clean_architecture/src/features/auth/domain/repositories/auth_repository.dart'
    as _i19;
import 'package:flutter_clean_architecture/src/features/auth/domain/usecases/get_saved_user.dart'
    as _i21;
import 'package:flutter_clean_architecture/src/features/splash/data/datasources/splash_local_data_source.dart'
    as _i10;
import 'package:flutter_clean_architecture/src/features/splash/data/datasources/splash_remote_data_source.dart'
    as _i11;
import 'package:flutter_clean_architecture/src/features/splash/data/repositories/splash_repository_impl.dart'
    as _i13;
import 'package:flutter_clean_architecture/src/features/splash/domain/repositories/splash_repository.dart'
    as _i12;
import 'package:flutter_clean_architecture/src/features/splash/domain/usecases/check_app_version.dart'
    as _i14;
import 'package:flutter_clean_architecture/src/features/splash/domain/usecases/check_user_token.dart'
    as _i15;
import 'package:flutter_clean_architecture/src/features/splash/presentation/bloc/splash_bloc.dart'
    as _i17;
import 'package:flutter_clean_architecture/src/infrastructure/di/injection_module.dart'
    as _i22;
import 'package:flutter_clean_architecture/src/infrastructure/network/token/app_token_provider.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i3.Dio>(() => injectionModule.dio);
    gh.factory<_i4.DioClientConfig>(() => injectionModule.dioClientConfig);
    gh.factory<_i5.ITokenProvider>(() => _i6.AppTokenProvider());
    gh.lazySingleton<_i7.InternetConnectionChecker>(
        () => injectionModule.connectionChecker);
    gh.lazySingleton<_i8.NetworkInfo>(
        () => _i8.NetworkInfoImpl(gh<_i7.InternetConnectionChecker>()));
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => injectionModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i10.SplashLocalDataSource>(() =>
        _i10.SplashLocalDataSourceImpl(
            sharedPreferences: gh<_i9.SharedPreferences>()));
    gh.lazySingleton<_i11.SplashRemoteDataSource>(
        () => _i11.SplashRemoteDataSourceImpl(client: gh<_i3.Dio>()));
    gh.lazySingleton<_i12.SplashRepository>(() => _i13.SplashRepositoryImpl(
          remoteDataSource: gh<_i11.SplashRemoteDataSource>(),
          localDataSource: gh<_i10.SplashLocalDataSource>(),
          networkInfo: gh<_i8.NetworkInfo>(),
        ));
    gh.lazySingleton<_i14.CheckAppVersion>(
        () => _i14.CheckAppVersion(gh<_i12.SplashRepository>()));
    gh.lazySingleton<_i15.CheckUserToken>(
        () => _i15.CheckUserToken(gh<_i12.SplashRepository>()));
    gh.factory<_i16.DioClient>(() => _i16.DioClient(gh<_i4.DioClientConfig>()));
    gh.factory<_i17.SplashBloc>(() => _i17.SplashBloc(
          checkAppVersion: gh<_i14.CheckAppVersion>(),
          checkUserToken: gh<_i15.CheckUserToken>(),
        ));
    gh.lazySingleton<_i18.AuthRemoteDataSource>(
        () => _i18.AuthRemoteDataSourceImpl(gh<_i16.DioClient>()));
    gh.lazySingleton<_i19.AuthRepository>(
        () => _i20.AuthRepositoryImpl(gh<_i18.AuthRemoteDataSource>()));
    gh.factory<_i21.GetSavedUser>(
        () => _i21.GetSavedUser(gh<_i19.AuthRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i22.InjectionModule {}
