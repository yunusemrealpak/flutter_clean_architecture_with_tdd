// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_clean_architecture/src/core/database/i_local_database.dart'
    as _i9;
import 'package:flutter_clean_architecture/src/core/network/cache/network_cache_manager.dart'
    as _i11;
import 'package:flutter_clean_architecture/src/core/network/dio_client.dart'
    as _i8;
import 'package:flutter_clean_architecture/src/core/network/dio_client_config.dart'
    as _i4;
import 'package:flutter_clean_architecture/src/core/network/interceptors/cache_interceptor.dart'
    as _i15;
import 'package:flutter_clean_architecture/src/core/network/token/token_provider.dart'
    as _i5;
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i12;
import 'package:flutter_clean_architecture/src/feature/auth/data/repositories/auth_repository_impl.dart'
    as _i14;
import 'package:flutter_clean_architecture/src/feature/auth/domain/repositories/auth_repository.dart'
    as _i13;
import 'package:flutter_clean_architecture/src/feature/auth/domain/usecases/get_saved_user.dart'
    as _i16;
import 'package:flutter_clean_architecture/src/infrastructure/core/database/isar_local_database.dart'
    as _i10;
import 'package:flutter_clean_architecture/src/infrastructure/core/database/isar_service.dart'
    as _i7;
import 'package:flutter_clean_architecture/src/infrastructure/di/injection_module.dart'
    as _i17;
import 'package:flutter_clean_architecture/src/infrastructure/network/token/app_token_provider.dart'
    as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i3.Dio>(() => injectionModule.dio);
    gh.factory<_i4.DioClientConfig>(() => injectionModule.dioClientConfig);
    gh.factory<_i5.ITokenProvider>(() => _i6.AppTokenProvider());
    gh.singletonAsync<_i7.IsarService>(() {
      final i = _i7.IsarService();
      return i.init().then((_) => i);
    });
    gh.factory<_i8.DioClient>(() => _i8.DioClient(gh<_i4.DioClientConfig>()));
    gh.factoryAsync<_i9.ILocalDatabase<dynamic>>(() async =>
        _i10.IsarLocalDatabase<dynamic>(await getAsync<_i7.IsarService>()));
    gh.lazySingletonAsync<_i11.INetworkCacheManager>(() async =>
        _i11.NetworkCacheManager(await getAsync<_i7.IsarService>()));
    gh.lazySingleton<_i12.AuthRemoteDataSource>(
        () => _i12.AuthRemoteDataSourceImpl(gh<_i8.DioClient>()));
    gh.lazySingleton<_i13.AuthRepository>(
        () => _i14.AuthRepositoryImpl(gh<_i12.AuthRemoteDataSource>()));
    gh.factoryAsync<_i15.CacheInterceptor>(() async => _i15.CacheInterceptor(
          await getAsync<_i11.INetworkCacheManager>(),
          defaultCacheDuration: gh<int>(),
        ));
    gh.factory<_i16.GetSavedUser>(
        () => _i16.GetSavedUser(gh<_i13.AuthRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i17.InjectionModule {}
