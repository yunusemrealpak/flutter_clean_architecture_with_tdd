// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/common/error/failure.dart';
import 'package:flutter_clean_architecture/src/feature/_common/cubit/base_cubit_state.dart';

import '../../domain/entities/post_entity.dart';

class PostState extends Equatable implements BaseCubitState {
  final bool isLoading;
  final Failure? failure;
  final List<PostEntity> posts;
  final PostEntity? post;

  const PostState({
    required this.isLoading,
    this.failure,
    required this.posts,
    this.post,
  });

  @override
  List<Object?> get props => [isLoading, failure, posts, post];
}
