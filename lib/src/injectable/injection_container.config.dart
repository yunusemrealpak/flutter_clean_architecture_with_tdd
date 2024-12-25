// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:flutter_clean_architecture/src/core/database/i_local_database.dart'
    as _i17;
import 'package:flutter_clean_architecture/src/core/network/cache/network_cache_manager.dart'
    as _i19;
import 'package:flutter_clean_architecture/src/core/network/dio_client.dart'
    as _i4;
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i3;
import 'package:flutter_clean_architecture/src/feature/auth/data/repositories/auth_repository_impl.dart'
    as _i6;
import 'package:flutter_clean_architecture/src/feature/auth/domain/repositories/auth_repository.dart'
    as _i5;
import 'package:flutter_clean_architecture/src/feature/auth/domain/usecases/get_saved_user.dart'
    as _i8;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart'
    as _i11;
import 'package:flutter_clean_architecture/src/feature/post/data/repositories/post_repository_impl.dart'
    as _i13;
import 'package:flutter_clean_architecture/src/feature/post/domain/repositories/post_repository.dart'
    as _i12;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_all_posts.dart'
    as _i14;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_by_id.dart'
    as _i15;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_saved_all_posts.dart'
    as _i16;
import 'package:flutter_clean_architecture/src/feature/post/presentation/cubit/post_cubit.dart'
    as _i10;
import 'package:flutter_clean_architecture/src/infrastructure/core/database/isar_local_database.dart'
    as _i18;
import 'package:flutter_clean_architecture/src/infrastructure/core/database/isar_service.dart'
    as _i9;
import 'package:flutter_clean_architecture/src/injectable/injection_module.dart'
    as _i20;
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
    gh.lazySingleton<_i3.AuthRemoteDataSource>(
        () => _i3.AuthRemoteDataSourceImpl(gh<_i4.DioClient>()));
    gh.lazySingleton<_i5.AuthRepository>(
        () => _i6.AuthRepositoryImpl(gh<_i3.AuthRemoteDataSource>()));
    gh.lazySingleton<_i7.Dio>(() => injectionModule.dio);
    gh.factory<_i8.GetSavedUser>(
        () => _i8.GetSavedUser(gh<_i5.AuthRepository>()));
    gh.singletonAsync<_i9.IsarService>(() {
      final i = _i9.IsarService();
      return i.init().then((_) => i);
    });
    gh.factory<_i10.PostCubit>(() => _i10.PostCubit());
    gh.lazySingleton<_i11.PostRemoteDataSource>(
        () => _i11.PostRemoteDataSourceImpl(gh<_i4.DioClient>()));
    gh.lazySingleton<_i12.PostRepository>(
        () => _i13.PostRepositoryImpl(gh<_i11.PostRemoteDataSource>()));
    gh.factory<_i14.GetAllPosts>(
        () => _i14.GetAllPosts(gh<_i12.PostRepository>()));
    gh.factory<_i15.GetById>(() => _i15.GetById(gh<_i12.PostRepository>()));
    gh.factory<_i16.GetSavedAllPosts>(
        () => _i16.GetSavedAllPosts(gh<_i12.PostRepository>()));
    gh.factoryAsync<_i17.ILocalDatabase<dynamic>>(() async =>
        _i18.IsarLocalDatabase<dynamic>(await getAsync<_i9.IsarService>()));
    gh.lazySingletonAsync<_i19.INetworkCacheManager>(() async =>
        _i19.NetworkCacheManager(await getAsync<_i9.IsarService>()));
    return this;
  }
}

class _$InjectionModule extends _i20.InjectionModule {}
