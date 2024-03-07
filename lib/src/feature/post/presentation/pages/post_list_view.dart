import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/core/extensions/dartz_extensions.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_by_id.dart';
import 'package:flutter_clean_architecture/src/feature/post/domain/usecases/get_saved_all_posts.dart';

import '../../../../injectable/injection_container.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  int postCount = 0;

  @override
  void initState() {
    super.initState();

    getPosts();
    //getPostById(-1);
  }

  Future<void> getPosts() async {
    final posts = await di<GetSavedAllPosts>().call();
    if (posts.isLeft()) {
      return;
    }
    Future.microtask(() => updatePostCount(posts.right?.length ?? -1));
  }

  Future<void> getPostById(int id) async {
    final post = await di<GetById>().call(id);
    if (post.isLeft()) {
      updatePostCount(-1);
      return;
    }
    Future.microtask(() => updatePostCount(1));
  }

  void updatePostCount(int count) {
    setState(() {
      postCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Post List - $postCount'),
      ),
    );
  }
}
