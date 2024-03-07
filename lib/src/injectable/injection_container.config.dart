// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i9;
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_rest_client.dart'
    as _i5;
import 'package:flutter_clean_architecture/src/feature/auth/data/repositories/auth_repository_impl.dart'
    as _i11;
import 'package:flutter_clean_architecture/src/feature/auth/domain/repositories/auth_repository.dart'
    as _i10;
import 'package:flutter_clean_architecture/src/feature/auth/domain/usecases/get_saved_user.dart'
    as _i13;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart'
    as _i6;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_rest_client.dart'
    as _i4;
import 'package:flutter_clean_architecture/src/feature/post/data/repositories/post_repository_impl.dart'
    as _i8;
import 'package:flutter_clean_architecture/src/feature/post/domain/repositories/post_repository.dart'
    as _i7;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_all_posts.dart'
    as _i12;
import 'package:flutter_clean_architecture/src/injectable/injection_module.dart' as _i14;
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
    gh.lazySingleton<_i4.PostRestClient>(() => _i4.PostRestClient(gh<_i3.Dio>()));
    gh.lazySingleton<_i5.AuthRestClient>(() => _i5.AuthRestClient(
          gh<_i3.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i6.PostRemoteDataSource>(
        () => _i6.PostRemoteDataSourceImpl(gh<_i4.PostRestClient>()));
    gh.lazySingleton<_i7.PostRepository>(
        () => _i8.PostRepositoryImpl(gh<_i6.PostRemoteDataSource>()));
    gh.lazySingleton<_i9.AuthRemoteDataSource>(
        () => _i9.AuthRemoteDataSourceImpl(gh<_i5.AuthRestClient>()));
    gh.lazySingleton<_i10.AuthRepository>(
        () => _i11.AuthRepositoryImpl(gh<_i9.AuthRemoteDataSource>()));
    gh.factory<_i12.GetAllPosts>(() => _i12.GetAllPosts(gh<_i7.PostRepository>()));
    gh.factory<_i13.GetSavedUser>(() => _i13.GetSavedUser(gh<_i10.AuthRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i14.InjectionModule {}
