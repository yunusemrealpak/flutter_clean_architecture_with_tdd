// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_clean_architecture/src/core/database/i_local_database.dart'
    as _i10;
import 'package:flutter_clean_architecture/src/core/network/cache/network_cache_manager.dart'
    as _i12;
import 'package:flutter_clean_architecture/src/core/network/dio_client.dart'
    as _i9;
import 'package:flutter_clean_architecture/src/core/network/dio_client_config.dart'
    as _i4;
import 'package:flutter_clean_architecture/src/core/network/interceptors/cache_interceptor.dart'
    as _i19;
import 'package:flutter_clean_architecture/src/core/network/token/token_provider.dart'
    as _i5;
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i16;
import 'package:flutter_clean_architecture/src/feature/auth/data/repositories/auth_repository_impl.dart'
    as _i18;
import 'package:flutter_clean_architecture/src/feature/auth/domain/repositories/auth_repository.dart'
    as _i17;
import 'package:flutter_clean_architecture/src/feature/auth/domain/usecases/get_saved_user.dart'
    as _i23;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart'
    as _i13;
import 'package:flutter_clean_architecture/src/feature/post/data/repositories/post_repository_impl.dart'
    as _i15;
import 'package:flutter_clean_architecture/src/feature/post/domain/repositories/post_repository.dart'
    as _i14;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_all_posts.dart'
    as _i20;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_by_id.dart'
    as _i21;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_saved_all_posts.dart'
    as _i22;
import 'package:flutter_clean_architecture/src/feature/post/presentation/cubit/post_cubit.dart'
    as _i8;
import 'package:flutter_clean_architecture/src/infrastructure/core/database/isar_local_database.dart'
    as _i11;
import 'package:flutter_clean_architecture/src/infrastructure/core/database/isar_service.dart'
    as _i7;
import 'package:flutter_clean_architecture/src/infrastructure/di/injection_module.dart'
    as _i24;
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
    gh.factory<_i8.PostCubit>(() => _i8.PostCubit());
    gh.factory<_i9.DioClient>(() => _i9.DioClient(gh<_i4.DioClientConfig>()));
    gh.factoryAsync<_i10.ILocalDatabase<dynamic>>(() async =>
        _i11.IsarLocalDatabase<dynamic>(await getAsync<_i7.IsarService>()));
    gh.lazySingletonAsync<_i12.INetworkCacheManager>(() async =>
        _i12.NetworkCacheManager(await getAsync<_i7.IsarService>()));
    gh.lazySingleton<_i13.PostRemoteDataSource>(
        () => _i13.PostRemoteDataSourceImpl(gh<_i9.DioClient>()));
    gh.lazySingleton<_i14.PostRepository>(
        () => _i15.PostRepositoryImpl(gh<_i13.PostRemoteDataSource>()));
    gh.lazySingleton<_i16.AuthRemoteDataSource>(
        () => _i16.AuthRemoteDataSourceImpl(gh<_i9.DioClient>()));
    gh.lazySingleton<_i17.AuthRepository>(
        () => _i18.AuthRepositoryImpl(gh<_i16.AuthRemoteDataSource>()));
    gh.factoryAsync<_i19.CacheInterceptor>(() async => _i19.CacheInterceptor(
          await getAsync<_i12.INetworkCacheManager>(),
          defaultCacheDuration: gh<int>(),
        ));
    gh.factory<_i20.GetAllPosts>(
        () => _i20.GetAllPosts(gh<_i14.PostRepository>()));
    gh.factory<_i21.GetById>(() => _i21.GetById(gh<_i14.PostRepository>()));
    gh.factory<_i22.GetSavedAllPosts>(
        () => _i22.GetSavedAllPosts(gh<_i14.PostRepository>()));
    gh.factory<_i23.GetSavedUser>(
        () => _i23.GetSavedUser(gh<_i17.AuthRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i24.InjectionModule {}
