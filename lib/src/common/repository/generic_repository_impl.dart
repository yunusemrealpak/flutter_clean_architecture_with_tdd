import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/src/common/repository/entity.dart';
import 'package:flutter_clean_architecture/src/common/repository/generic_repository_method_type.dart';
import 'package:flutter_clean_architecture/src/core/extensions/map_extensions.dart';

import '../utils/typedef.dart';
import 'generic_repository.dart';

abstract class GenericRepositoryImpl<T extends Entity> implements GenericRepository<T> {
  final T parserModel;
  final Map<GenericRepositoryMethod, String> networkPaths;

  GenericRepositoryImpl({required this.parserModel, required this.networkPaths})
      : assert(networkPaths.isNotEmpty, 'networkPaths cannot be empty'),
        assert(networkPaths.existsAllKeys(GenericRepositoryMethod.values),
            'networkPaths must contain all GenericRepositoryMethod values');

  @override
  EitherFuture<List<T>> getAll() async {
    final networkPath = networkPaths[GenericRepositoryMethod.getAll]!;

    return right([]);
  }

  @override
  EitherFuture<T> getById(int id) async {
    final networkPath = networkPaths[GenericRepositoryMethod.getById]!;

    return right(parserModel);
  }
}
