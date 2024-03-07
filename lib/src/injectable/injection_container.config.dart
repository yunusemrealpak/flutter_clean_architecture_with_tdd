// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_clean_architecture/src/common/local_database/local_db_manager.dart'
    as _i4;
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i13;
import 'package:flutter_clean_architecture/src/feature/auth/data/data_sources/remote/auth_rest_client.dart'
    as _i9;
import 'package:flutter_clean_architecture/src/feature/auth/data/repositories/auth_repository_impl.dart'
    as _i15;
import 'package:flutter_clean_architecture/src/feature/auth/domain/repositories/auth_repository.dart'
    as _i14;
import 'package:flutter_clean_architecture/src/feature/auth/domain/usecases/get_saved_user.dart'
    as _i19;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/local/post_local_client.dart'
    as _i6;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/local/post_local_data_source.dart'
    as _i7;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_remote_data_source.dart'
    as _i10;
import 'package:flutter_clean_architecture/src/feature/post/data/data_sources/remote/post_rest_client.dart'
    as _i8;
import 'package:flutter_clean_architecture/src/feature/post/data/repositories/post_repository_impl.dart'
    as _i12;
import 'package:flutter_clean_architecture/src/feature/post/domain/repositories/post_repository.dart'
    as _i11;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_all_posts.dart'
    as _i16;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_by_id.dart'
    as _i17;
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_saved_all_posts.dart'
    as _i18;
import 'package:flutter_clean_architecture/src/feature/post/presentation/cubit/post_cubit.dart'
    as _i5;
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
    gh.lazySingleton<_i3.Dio>(() => injectionModule.dio);
    gh.lazySingleton<_i4.LocalDBManager>(() => _i4.LocalDBManager());
    gh.factory<_i5.PostCubit>(() => _i5.PostCubit());
    gh.factory<_i6.PostLocalClient>(
        () => _i6.PostLocalClient(gh<_i4.LocalDBManager>()));
    gh.lazySingleton<_i7.PostLocalDataSource>(
        () => _i7.PostLocalDataSourceImpl(gh<_i6.PostLocalClient>()));
    gh.lazySingleton<_i8.PostRestClient>(
        () => _i8.PostRestClient(gh<_i3.Dio>()));
    gh.lazySingleton<_i9.AuthRestClient>(() => _i9.AuthRestClient(
          gh<_i3.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.lazySingleton<_i10.PostRemoteDataSource>(
        () => _i10.PostRemoteDataSourceImpl(gh<_i8.PostRestClient>()));
    gh.lazySingleton<_i11.PostRepository>(() => _i12.PostRepositoryImpl(
          gh<_i10.PostRemoteDataSource>(),
          gh<_i7.PostLocalDataSource>(),
        ));
    gh.lazySingleton<_i13.AuthRemoteDataSource>(
        () => _i13.AuthRemoteDataSourceImpl(gh<_i9.AuthRestClient>()));
    gh.lazySingleton<_i14.AuthRepository>(
        () => _i15.AuthRepositoryImpl(gh<_i13.AuthRemoteDataSource>()));
    gh.factory<_i16.GetAllPosts>(
        () => _i16.GetAllPosts(gh<_i11.PostRepository>()));
    gh.factory<_i17.GetById>(() => _i17.GetById(gh<_i11.PostRepository>()));
    gh.factory<_i18.GetSavedAllPosts>(
        () => _i18.GetSavedAllPosts(gh<_i11.PostRepository>()));
    gh.factory<_i19.GetSavedUser>(
        () => _i19.GetSavedUser(gh<_i14.AuthRepository>()));
    return this;
  }
}

class _$InjectionModule extends _i20.InjectionModule {}
