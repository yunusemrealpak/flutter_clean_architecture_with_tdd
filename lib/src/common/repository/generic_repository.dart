import 'package:flutter_clean_architecture/src/common/repository/entity.dart';

import '../utils/typedef.dart';

abstract interface class GenericRepository<T extends Entity> {
  /// Retrieves an entity by its ID.
  /// Returns an [EitherFuture] that represents the result of the operation.
  /// If the operation is successful, the [EitherFuture] will contain the entity.
  /// If the operation fails, the [EitherFuture] will contain an error.
  EitherFuture<T> getById(int id);

  /// Retrieves all entities.
  /// Returns an [EitherFuture] that represents the result of the operation.
  /// If the operation is successful, the [EitherFuture] will contain a list of entities.
  /// If the operation fails, the [EitherFuture] will contain an error.
  EitherFuture<List<T>> getAll();
}
